<?php

//     *** PARAMETERS ***
$prob_threshold=0.35;
$s2=6.8;  //check other values
$CHECK_MILESTONES=true;
$LEN_W=0.7;
$CAPS_W=0.3;
$THRESHOLD_SCORE=0.35;
$DELTA_M_MIN=0.0;
$DELTA_P_MIN=0.0;
//

$SEP1="\n----------------------------------------------------------------------\n";
$SEP2="\n======================================================================\n";
$SEP3="\n\n§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§\n";

function match_scores($str_eng, $str_greek, $isAfterFS, $c, $s2) {
//strings
$s_eng=preg_replace('/[[:digit:][:space:][:punct:]]+/u', '', $str_eng);
$s_greek=preg_replace('/[[:digit:][:space:][:punct:]]+/u', '', $str_greek);
//length
$l_eng=grapheme_strlen($s_eng);
$l_greek=grapheme_strlen($s_greek);
//count upper - filtra I per l'inglese 
$s_eng_C=$isAfterFS?
         preg_replace('/[^[:upper:]]+/u', '', str_replace('I ','',substr($str_eng,1) )):
         preg_replace('/[^[:upper:]]+/u', '', str_replace('I ','',$str_eng) );
         
$s_greek_C=preg_replace('/[^[:upper:]]+/u', '', $s_greek);
$l_eng_C=grapheme_strlen($s_eng_C);
$l_greek_C=grapheme_strlen($s_greek_C);

$m=( $l_eng + $l_greek/$c )/2;
$z=abs( $c*$l_eng - $l_greek ) / sqrt( $s2 * $m );
$pnorm=stats_cdf_normal( $z, 0, 1, 1);
$pd= 2*( 1 - $pnorm );

/*
$z=abs( $l_greek - $c*$l_eng ) / sqrt( $s2 * $l_eng );
$pnorm=stats_cdf_normal( $z, 0, 1, 1);
$pd= 2*( 1 - $pnorm );
*/

//if ($pd>0) $res=(-100*log($pd));
$res = array(
            'eng_length'=>$l_eng,
            'greek_length'=>$l_greek,
            'eng_no_caps'=>$l_eng_C,
            'greek_no_caps'=>$l_greek_C,
            'prob'=>$pd,
            'log_prob'=>($pd>0)?(-100*log($pd)):NULL
       );

return $res;
}

function score($str_eng,$str_greek,$isAfterFS, $c, $s2,$LEN_W,$CAPS_W) {
    $res=match_scores($str_eng, $str_greek, $isAfterFS, $c, $s2);
    
    //chech Capital Letters
    $diffNoCaps=$res['eng_no_caps']-$res['greek_no_caps'];
    // se dopo il punto incertezza sul primo
    if ( $isAfterFS AND $diffNoCaps>1 ) $diffNoCaps--;
    $p_delta_C=(max($res['eng_no_caps'],$res['greek_no_caps'])>0)?
                abs($diffNoCaps)/max($res['eng_no_caps'],$res['greek_no_caps']):0;
    
    //check length
    $score=$LEN_W*$res['prob']+$CAPS_W*$p_delta_C;
    
    return $score;
}


function db_query($conn,$query){
    $queryRes=mysqli_query($conn,$query);
    if (!$queryRes ) {
        echo "DB ERROR\n";
        echo "MySQL: (" . mysqli_errno($conn) . ") " . mysqli_error($conn)."\n";
        echo "QUERY(".$query.")\n";
        exit;
    } 
    return $queryRes;
}

function my_log($msg,$echo) {
    if ($echo) {
        echo $msg;
    }
    error_log($msg, 3, "./tmp_log.log");
}

function reset_log($store) {
    if ($store) {
        $curlog = file_get_contents("./tmp_log.log");
        file_put_contents("./align_error.log", $curlog, FILE_APPEND | LOCK_EX);
    }
    unlink("./tmp_log.log");
} 

//CONNECTION
$mysqli = new mysqli("localhost", "root", "hodel_db_PaSsWoRd", "hodel_test");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
$mysqli->set_charset('utf8');


//INIT
$queryC="DROP TABLE IF EXISTS Sentence_align";
mysqli_query($mysqli,$queryC);
$queryC="
       CREATE TABLE Sentence_align( 
         poem_id VARCHAR(60) NOT NULL,
         book_id int(10) unsigned NOT NULL,
         para_start int(10) unsigned NOT NULL,
         para_end int(10) unsigned NULL,
         sent_start int(10) unsigned NOT NULL,
         sent_end int(10) unsigned NOT NULL,
         sent_id int(10) unsigned NOT NULL,
         sent_greek text NOT NULL DEFAULT '',
         sent_eng text NOT NULL DEFAULT '',
         sent_greek_l int(10) unsigned NOT NULL DEFAULT 0,
         sent_eng_l int(10) unsigned NOT NULL DEFAULT 0         
      )";
db_query($mysqli,$queryC);

// STAT PARAMS
$query_stat="
SELECT poem_id, SUM(greek_para_l)/SUM(eng_para_l) AS c
FROM Book_paras
GROUP BY poem_id
";

$result = db_query($mysqli,$query_stat);

$row = mysqli_fetch_array($result);

$c=$row['c'];


my_log("--------STATS PARAMS-----------\n".
       "|\tc =".$c."\n".
       "|\ts2 =".$s2."\n".
       "|\tProb. Threshold =".$prob_threshold."\n".
       "|\tMilestones check: ".$CHECK_MILESTONES."\n".
       "-------------------------------\n", true);


//poems
$poemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";

//LOOP PARAS
$queryParas="
SELECT book_id, start AS para_start, end AS para_end, eng_para
FROM Book_paras
WHERE poem_id='".$poemID."'
 AND book_id=1 ".
//" AND start IN (312,386,428,458)".
"";
$Paras = db_query($mysqli,$queryParas);
$para_count=0;
$para_aligned=0;
$para_tot_score=0.0;

reset_log(false);
unlink("./alignment_res.txt");

$para_greek_sents_list=array();

while( $rowParas=mysqli_fetch_array($Paras) ) {
    
    $align_sizes=array();
    $results_content='';
    $results_header='';
    
    my_log( "\nprocessing PARA: ".
          " BOOK=".$rowParas['book_id'].
          " START=".$rowParas['para_start'].
          " END=".$rowParas['para_end'].$SEP2, true);

    // ***** OUT RESULTS ********
    //OUT
    $results_header.= $SEP3.
              " BOOK=".$rowParas['book_id'].
              " START=".$rowParas['para_start'].
              " END=".$rowParas['para_end'].$SEP3;
    // ***** OUT RESULTS ********
    
    preg_match_all('~([^.?!:]+[.?!:]"?)~',$rowParas['eng_para'],$out);
    $sent_eng=$out[1];
    //var_dump($sent_eng);
    $noSentEng=count($sent_eng);

    //PARA GREEK SENTS
    $endWhere=isset($rowParas['para_end'])?" AND sent_end<=".$rowParas['para_end']:"";
    $queryGreekSents="
    SELECT sent_id, sent_start, sent_end, 
           TRIM( GROUP_CONCAT( CONCAT( IF(posAGDT<>'u',' ',''), forma) ORDER BY rank SEPARATOR '')) AS sent_greek,
           SUM( IF(posAGDT<>'u',CHAR_LENGTH(forma),0) ) AS sent_greek_l  
    FROM ( 
           SELECT document_id AS poem_id, 
           CAST( SUBSTRING_INDEX(subdoc,'.',1)  AS UNSIGNED) AS book_id,
           CAST( SUBSTRING_INDEX( SUBSTRING_INDEX(subdoc,'-',1),'.',-1)  AS UNSIGNED) sent_start, 
           CAST( SUBSTRING_INDEX( SUBSTRING_INDEX(subdoc,'-',-1),'.',-1)  AS UNSIGNED)  sent_end,
           Sentence.id AS sent_id,
           forma, posAGDT, rank
           FROM Sentence 
           INNER JOIN Forma
                ON (frase=Sentence.id)
          ) G 
    WHERE poem_id='".$poemID."' AND book_id=".$rowParas['book_id']." AND sent_start>=".$rowParas['para_start']
    .$endWhere." 
    GROUP BY sent_id, sent_start, sent_end
    ";   
    $GreekSents = db_query($mysqli,$queryGreekSents);
    $noGreekSents=mysqli_num_rows($GreekSents);
    my_log( " NO_ENG_SENTS=".$noSentEng.
          " NO_GREEK_SENTS=".$noGreekSents.$SEP2,true);


// ALIGN eng2gr

    my_log("ENG ---> GREEK\n",false);
    $eng2gr=array();
    $greekSentStartIndex=0;
    $sent_lower_limit=$rowParas['para_start'];
    $sent_upper_limit=$sent_lower_limit+5-($sent_lower_limit %5); //sistemare
    $aligned_eng_sents=0;
    $aligned_greek_sents=0;
    $tot_score=0.0;
    $min_delta_p=1.0;
    $min_delta_m=1.0;
    $greekSentEnd=0;
    
    for ($engSentIndex=0; $engSentIndex<$noSentEng; $engSentIndex++) {
        
        
        //milestones
        preg_match_all('~\[(\d+)\]~',$sent_eng[$engSentIndex],$out);
        $milestones_i= array_unique( array_map('intval', $out[1]) );
        $no_milestones_i = count($milestones_i);
        
        if ($no_milestones_i>0) {
            
            //VIOLAZIONE UNO A MOLTI??
            if ( $milestones_i[0] < $greekSentEnd ) {
                my_log(">>> FIRST MILESTONE ".$milestones_i[0].
                       " PRECEDING current greek sent: ".$greekSentEnd.
                       " MERGING cur eng sent".$engSentIndex,false);
                $engSentIndex--;
                $noSentEng--;
                my_log(" with prev ".$engSentIndex.
                       " no sents eng ".$noSentEng,false);
                $sent_eng[$engSentIndex] .= $sent_eng[$engSentIndex+1];
                array_splice($sent_eng,$engSentIndex+1,1);
                $score=$eng2gr[$engSentIndex]['score'];
                $greek_sents_list=$eng2gr[$engSentIndex]['sents_list'];
                if (count($greek_sents_list)>0) {
                    $aligned_eng_sents--;
                    $aligned_greek_sents-=count($greek_sents_list);
                    $tot_score-=$score;
                }
                array_splice($eng2gr,$engSentIndex,1);
                $engSentIndex--;
                if ($engSentIndex>=0) {
                    $greekSentEnd=$eng2gr[$engSentIndex]['end'];
                    $greekSentStartIndex=$eng2gr[$engSentIndex]['next_index'];
                } else {
                    $greekSentEnd=0;
                    $greekSentStartIndex=0;
                }
            
                my_log(" new Index ".$engSentIndex." greek sent: ".$greekSentEnd.
                " next greek sent index: ".$greekSentStartIndex."\n",false);
                
                $p=strrpos($results_content,$SEP2);
                $results_content = substr_replace($results_content,'',$p);
                
                continue;
            }
            
            $sent_upper_limit = is_null($rowParas['para_end'])?$milestones_i[$no_milestones_i-1]+5:
                               min($milestones_i[$no_milestones_i-1]+5,$rowParas['para_end']);
            $sent_lower_limit = max($milestones_i[0]-5,$rowParas['para_start']);
        }
        
        my_log("SENT ID: ".$engSentIndex.
               " LL: ".$sent_lower_limit."; UL: ".$sent_upper_limit."\n",false);

        if ( $greekSentStartIndex >= $noGreekSents ) {
            my_log("ALIGN ERROR! no more greek sents\n", false);
            break;
        }
        
        mysqli_data_seek ( $GreekSents , $greekSentStartIndex );
        $greekSentIndex=$greekSentStartIndex;
        $score=0.0;
        $greekPara='';
        $greek_sents_list=array();
        //$scores=array();
        while ( $rowGreekSents=mysqli_fetch_array($GreekSents) ) {
            
            my_log("\t greek sent. ".$rowGreekSents['sent_id'].
                   " (".$rowGreekSents['sent_start'].",".$rowGreekSents['sent_end'].")", false);
            
            if ($greekSentIndex == $greekSentStartIndex) {
                $greekSentStart=$rowGreekSents['sent_start'];
            }
            
            if ($rowGreekSents['sent_start']>$sent_upper_limit) {
                my_log("\t\t OUT BOUND\n", false);
                break;
            }
            $greekPara.=$rowGreekSents['sent_greek'];
            $new_score=score($sent_eng[$engSentIndex], $greekPara, 1, $c,$s2,$LEN_W,$CAPS_W);
//            if ($new_score<$score) {
            if (
                  (($new_score<$score) AND ($score-$new_score>$DELTA_M_MIN))
                OR 
                  (($new_score>=$score) AND ($new_score-$score<$DELTA_P_MIN))  
                  ) {
                
                $delta_m=$score-$new_score;
                $min_delta_m=min($min_delta_m,$delta_m);
             
                my_log("\t\t OUT SCORE (".$new_score."<".$score." delta=".$delta_m.")\n", false);
                break;
            }
            
            $delta_p=$new_score-$score;
            $min_delta_p=min($min_delta_p,$delta_p);
            
            $greekSentEnd=$rowGreekSents['sent_end'];
            $score=$new_score;
/*
            $greek_sents_list[]=array('id' => $rowGreekSents['sent_id'],
                                      'start' => $rowGreekSents['sent_start'],
                                      'end' => $rowGreekSents['sent_end'] );
*/
            $greek_sents_list[]=$rowGreekSents['sent_id'];
            my_log("\t\t IN new_score =".$score." delta=".$delta_p."\n", false);
            $greekSentIndex++;
        }
        
        
        $eng2gr[] = array('start' => $greekSentStart,
                           'end' => $greekSentEnd,
                           'score' => $score,
                           'sents_list' => $greek_sents_list,
                           'next_index' => $greekSentIndex,
                           /*'scores' => $scores*/ );
        $greekSentStartIndex = $greekSentIndex;

        if ($no_milestones_i>0) {
            $sent_lower_limit = $milestones_i[$no_milestones_i-1];
        }
        
        if (count($greek_sents_list)>0) {
            $aligned_eng_sents++;
            $aligned_greek_sents+=count($greek_sents_list);
            $tot_score+=$score;
        }

        // ***** OUT RESULTS ********
        $eng_para = mysqli_real_escape_string ($mysqli,$sent_eng[$engSentIndex]);
        $para_end=is_null($rowParas['para_end'])?"NULL":$rowParas['para_end'];
        
        //OUT
        $results_content .= $SEP2.$sent_eng[$engSentIndex];
        
        if (count($greek_sents_list)>0) {
            $para_greek_sents_list = array_merge($para_greek_sents_list,$greek_sents_list);
            $queryConcatGreek="SELECT GROUP_CONCAT(CONCAT('[',sent_start,',', sent_end,']',sent_greek) SEPARATOR '||') AS greek_para FROM (".
            $queryGreekSents.") GR  
            WHERE sent_id IN(".implode(',',$greek_sents_list).")
            ORDER BY sent_id
            ";   
            
            $ConcatGreek = db_query($mysqli,$queryConcatGreek);
            $rowConcatGreek=mysqli_fetch_array($ConcatGreek);
            $greek_para = mysqli_real_escape_string ($mysqli,$rowConcatGreek['greek_para']);
            
            $queryI="INSERT INTO Sentence_align(
            poem_id, book_id, para_start, para_end, sent_start, sent_end, sent_greek, sent_eng) 
            VALUES ("."'".$poemID."',".$rowParas['book_id'].",".$rowParas['para_start'].",".$para_end.
            ",".$greekSentStart.",".$greekSentEnd.",'".$greek_para."','".$eng_para."')
            ";
        
            //OUT
            $results_content .= $SEP1.$rowConcatGreek['greek_para']."\n\n";
            
            
        } else {
            $queryI="INSERT INTO Sentence_align(
            poem_id, book_id, para_start, para_end, sent_eng) 
            VALUES ("."'".$poemID."',".$rowParas['book_id'].",".$rowParas['para_start'].",".$para_end.
            ",'".$eng_para."')
            ";
            //OUT
            $results_content .= $SEP1."NULL"."\n\n";
        }
        db_query($mysqli,$queryI);
        
        // ***** OUT RESULTS ********


    }
    
    my_log("ENG2GR:\n".print_r($eng2gr,true)."\n", false);

    // ***** OUT RESULTS ********
    if ( $aligned_greek_sents<$noGreekSents ) {
        $queryConcatGreek="SELECT GROUP_CONCAT(sent_greek SEPARATOR '||') AS greek_para FROM (".
        $queryGreekSents.") GR  
        WHERE sent_id NOT IN(".implode(',',$para_greek_sents_list).")
        ORDER BY sent_id
        ";   
        
        $ConcatGreek = db_query($mysqli,$queryConcatGreek);
        $rowConcatGreek=mysqli_fetch_array($ConcatGreek);
        $greek_para = mysqli_real_escape_string ($mysqli,$rowConcatGreek['greek_para']);
        
        $para_end=is_null($rowParas['para_end'])?"NULL":$rowParas['para_end'];
        $queryI="INSERT INTO Sentence_align(
        poem_id, book_id, para_start, para_end, sent_greek) 
        VALUES ("."'".$poemID."',".$rowParas['book_id'].",".$rowParas['para_start'].",".$para_end.
        ",'".$greek_para."')
        ";
        db_query($mysqli,$queryI);
        //OUT
        $results_content .= $SEP2."NULL".$SEP1.$rowConcatGreek['greek_para']."\n\n";
    }
    if ( $engSentIndex<$noSentEng ) {
        for (; $engSentIndex<$noSentEng; $engSentIndex++) {
            $eng_para = mysqli_real_escape_string ($mysqli,$sent_eng[$engSentIndex]);
            $para_end=is_null($rowParas['para_end'])?"NULL":$rowParas['para_end'];
            
            //OUT
            $results_content .= $SEP2.$sent_eng[$engSentIndex].$SEP1."NULL"."\n\n";
            
            $queryI="INSERT INTO Sentence_align(
            poem_id, book_id, para_start, para_end, sent_eng) 
            VALUES ("."'".$poemID."',".$rowParas['book_id'].",".$rowParas['para_start'].",".$para_end.
            ",'".$eng_para."')
            ";
        }
//        $results_content .= $SEP2."HHHHHHHHHHOOOOOOOOOOOOLLLLLLLLLLEEEEEEEEE".$SEP1."NULL"."\n\n";
    }
    // ***** OUT RESULTS ********

    
    if ( $aligned_eng_sents==$noSentEng  AND $aligned_greek_sents==$noGreekSents ) {
        $para_score=$tot_score / $aligned_eng_sents;
        my_log( "\nSUCCESS!!! ".
              " avg prob=".$para_score."\n min_delta_p=".$min_delta_p." min_delta_m=".$min_delta_m.
              $SEP2, true);
        $results_header .= "\nSUCCESS!!! ".$SEP3;
        $para_aligned++;
        $para_tot_score+=$para_score;
        
    } else {
        $para_score=$tot_score / $aligned_eng_sents;
        my_log( "\n UN-SUCCESS!! NOT ALIGNED ENG SENTS=".($noSentEng-$aligned_eng_sents).
              " NOT ALIGNED GREEK SENTS=".($noGreekSents-$aligned_greek_sents).
              " avg prob=".$para_score."\n min_delta_p=".$min_delta_p." min_delta_m=".$min_delta_m.
              $SEP2,true);
        $results_header .= "\n UN-SUCCESS!! NOT ALIGNED ENG SENTS=".($noSentEng-$aligned_eng_sents).
              " NOT ALIGNED GREEK SENTS=".($noGreekSents-$aligned_greek_sents).$SEP3;
    }

     
    file_put_contents("./alignment_res.txt", $results_header.$results_content, FILE_APPEND | LOCK_EX);
    
    $para_count++;

} //LOOP PARAS

my_log( "\n\n######  PARA ALIGNED: ".$para_aligned."/".$para_count." avg SCORE=".($para_tot_score/$para_aligned)
       ."  ##################\n",true);


/*
$csv = 'prova_alignment.csv';
$fp  = fopen($csv, 'w');
$sql = "SELECT sent_eng,sent_greek FROM Sentence_align";
$res = db_query($mysqli,$sql);
while ($row = mysqli_fetch_row($res))
{
    // WRITE THE COMMA-SEPARATED VALUES.  MAN PAGE http://php.net/manual/en/function.fputcsv.php
    if (!fputcsv($fp, $row)) die('CATASTROPHE');
}

// ALL DONE
fclose($fp);
*/

?>
