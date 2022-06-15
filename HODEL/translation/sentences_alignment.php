<?php

//     *** PARAMETERS ***
$prob_threshold=0.35;
$s2=6.8;  //check other values
$CHECK_MILESTONES=true;
$LEN_W=0.8;
$CAPS_W=0.2;
$THRESHOLD_SCORE=0.35;
//

/**
 * linear regression function
 * @param $x array x-coords
 * @param $y array y-coords
 * @returns array() m=>slope, b=>intercept
 */
function linear_regression($conn) {

//get samples
$get_stats=
"SELECT poem_id, book_id,
 eng_para_l, POW(CAST(greek_para_l AS SIGNED) - CAST(eng_para_l AS SIGNED),2) AS sd 
FROM Book_paras
ORDER BY eng_para_l ASC
";

$result = mysqli_query($conn,$get_stats);
$x=array();
$y=array();
while($row = $result->fetch_array())
{
    $x[]=$row['eng_para_l'];
    $y[]=$row['sd'];
}
////

  // calculate number points
  $n = count($x);
  
  // ensure both arrays of points are the same size
  if ($n != count($y)) {

    trigger_error("linear_regression(): Number of elements in coordinate arrays do not match.", E_USER_ERROR);
  
  }

  // calculate sums
  $x_sum = array_sum($x);
  $y_sum = array_sum($y);

  $xx_sum = 0;
  $xy_sum = 0;
  
  for($i = 0; $i < $n; $i++) {
  
    $xy_sum+=($x[$i]*$y[$i]);
    $xx_sum+=($x[$i]*$x[$i]);
    
  }
  
  // calculate slope
  $m = (($n * $xy_sum) - ($x_sum * $y_sum)) / (($n * $xx_sum) - ($x_sum * $x_sum));
  
  // calculate intercept
  $b = ($y_sum - ($m * $x_sum)) / $n;
    
  // return result
  return array("m"=>$m, "b"=>$b);

}

function match_scores($str_eng,$str_greek, $c, $s, $s2,$isAfterFS/*,$c_1*/) {
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

//$c=1;
//$s2=6.8;
//$s2=5.6;
/**/
$m=( $l_eng + $l_greek/$c )/2;
$z=abs( $c*$l_eng - $l_greek ) / sqrt( $s2 * $m );
$pnorm=stats_cdf_normal( $z, 0, 1, 1);
$pd= 2*( 1 - $pnorm );

/**/
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
    $res=match_scores($str_eng,$str_greek, $c, 0, $s2,$isAfterFS);
    
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
$mysqli = new mysqli("localhost", "root", "PaShalom", "hodel_test");
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
SELECT poem_id, SUM(greek_para_l)/SUM(eng_para_l) AS c,
SUM(eng_para_l)/SUM(greek_para_l) AS c_1 
FROM Book_paras
GROUP BY poem_id
";

$result = db_query($mysqli,$query_stat);

$row = mysqli_fetch_array($result);

$c=$row['c'];

/*
$c_1=$row['c_1'];
$res=linear_regression($mysqli);

echo "--------STATS PARAMS-----------\n";
echo "c=".$c."\n";
echo "c_1=".$c_1."\n";
echo "linear regression: m=(".$res['m']."); b=(".$res['b'].")\n";
echo "-------------------------------\n";
*/

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
 AND book_id=1
";
$Paras = db_query($mysqli,$queryParas);
$para_count=0;
$para_aligned=0;

while( $rowParas=mysqli_fetch_array($Paras) ) {
    
    $align_sizes=array();
    
    my_log( "\nprocessing PARA: ".
          " BOOK=".$rowParas['book_id'].
          " START=".$rowParas['para_start'].
          " END=".$rowParas['para_end']."\n".
          "==================================================\n", true);
    
    preg_match_all('~([^.?!:]+[.?!:]"?)~',$rowParas['eng_para'],$out);
    $sent_eng=$out[1];
    //var_dump($sent_eng);
    $no_sent_eng=count($sent_eng);

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
    my_log( " NO_ENG_SENTS=".$no_sent_eng.
          " NO_GREEK_SENTS=".$noGreekSents."\n".
          "==================================================\n",true);
    //init candidate
    $residual='';  
    $greekSentIndex=0;
    $engSentIndex=0; 
    $greek_eng=array();
    $candidates_weak_p_cut=NULL;
    $candidate=$sent_eng[$engSentIndex];
    $isAfterFS=1; 
    $findMore=false;
    while( true ) {
        
        //var_dump($greekSentIndex);
        
        mysqli_data_seek ( $GreekSents , $greekSentIndex );
        $rowGreekSents=mysqli_fetch_array($GreekSents);
        
        my_log( "\n==================================================\n".
              "Greek Sent (".($greekSentIndex+1)."/".$noGreekSents."):\n".$rowGreekSents['sent_greek']."\n".
              " START=".$rowGreekSents['sent_start'].
              " END=".$rowGreekSents['sent_end'].
              " LENGTH=".$rowGreekSents['sent_greek_l']."\n".
              "----------------------------------------------------\n", false);
        
        my_log( "Candidate Translation:\n".$candidate."\n".
              "----------------------------------------------------\n\n",false);
              
        if ( $CHECK_MILESTONES ) {
            //check milestones
            preg_match_all('~\[(\d+)\]~',$candidate,$out);
            $milestones= array_unique( array_map('intval', $out[1]) );
            //var_dump($milestones);
            $check_m=1;
            $position=0;
            $offending_milestone='';
            foreach ($milestones as $m){
                if ( $m>$rowGreekSents['sent_end'] ) {
                    $check_m=0;
                    $position=$m;
                    break;
                }
            }
            if ($check_m) {
                my_log( "\t - milestone check: OK\n",false);
            } else {
                $offending_milestone = "[".$position."]";
                my_log( "\t - milestone check: NOK! - OFFENDING MILESTONE: ".$offending_milestone."\n",false);
                //cut alla prima punteggiatura debole
                //posizione del milestone
    
                $pos = strpos($candidate,$offending_milestone);
                $break_offset = $pos - strlen($candidate);
                $anyWeak_p=preg_match_all('~[,;]~', substr($candidate,0,$break_offset), $weak_p, PREG_OFFSET_CAPTURE);
                if ( $anyWeak_p )
                {
                    $first_weak_p=end($weak_p[0]);
                    $break_pos=$first_weak_p[1];
                    $str1 = substr($candidate,0,$break_pos+1);
                    $str2 = substr($candidate,$break_pos + 1);
                    my_log( "\t----------------------------------------------------\n".
                          "\tCANDIDATE CUT:\n\t <<<".$str1.">>>\n\t<<<".$str2.">>>\n",false);
                    $candidate=$str1;
                    $residual=$str2;
                } else {
                    my_log( "\t----------------------------------------------------\n".
                          "\tNO CANDIDATE BREAK FOUND!\n",false);
                }
            
            }
        } //chech milestones
        
        
        do {
/*            
            //get scores
            $res=match_scores($candidate,$rowGreekSents['sent_greek'],$c,0,$s2,$isAfterFS);
                    
            //chech Capital Letters
            $diffNoCaps=$res['eng_no_caps']-$res['greek_no_caps'];
            // se dopo il punto incertezza sul primo
            $check_C=(  $diffNoCaps==0 OR ( $isAfterFS AND $diffNoCaps==1 ) )?true:false;
            if ($check_C) {
                my_log( "\t - No Capital Letters check: OK\n",false);
            } else {
                my_log( "\t - No Capital Letters check: NOK! - ENG CAPS: ".$res['eng_no_caps'].
                      " - Greek CAPS: ".$res['greek_no_caps']."\n",false);
            }
    
            //check length prob
            $check_L=($res['prob']>$prob_threshold)?true:false;
            if ($check_L) {
                my_log( "\t - Length check: OK - PROB=".$res['prob']."\n",false);
            } else {
                my_log( "\t - Length check: NOK - PROB=".$res['prob']."\n",false);
            }
            
            if (!$check_C OR !$check_L OR $findMore) {
*/

            $score = score($candidate,$rowGreekSents['sent_greek'],$isAfterFS,$c,$s2,$LEN_W,$CAPS_W);
            if ($score >= $THRESHOLD_SCORE) {
                my_log( "\t - SCORE CHECK: OK (".$score." [".$THRESHOLD_SCORE."]\n",false);
            } else {
                my_log( "\t - SCORE CHECK: NOK (".$score." [".$THRESHOLD_SCORE."]\n",false);
            }
            
            if ( ($score < $THRESHOLD_SCORE) OR $findMore) {
//                
                if ( !isset($candidates_weak_p_cut) ) {
                    //find candidate cuts
                    my_log( "Searching for candidate cuts...\n",false);
                    $anyWeak_p=preg_match_all('~[,;]~u', 
                                              substr($candidate,0,strlen($candidate)-1), //nb salta ultimo 
                                              $weak_p, PREG_OFFSET_CAPTURE);
                    $candidates_weak_p_cut=$weak_p[0];
                    if ( !$anyWeak_p ) {
                        my_log( "\t----------------------------------------------------\n".
                              "\tNO CANDIDATE CUT FOUND! GIVING UP...\n",false);
                        break;
                    }
                } 
                
                //pop next candidate
                $cur_weak_p=array_pop($candidates_weak_p_cut);
                if ($cur_weak_p) {
                    //print_r($cur_weak_p);
                    $break_pos=$cur_weak_p[1];
                    $str1 = substr($candidate,0,$break_pos+1);
                    $str2 = substr($candidate,$break_pos + 1);
                    my_log( "\t----------------------------------------------------\n".
                         "\tCANDIDATE CUT <<<".$str1.">>>\n\t<<<".$str2.">>>\n",false);
                    $candidate=$str1;
                    $residual=$str2.$residual;
                } else {
                    my_log( "\t----------------------------------------------------\n".
                          "\tNO MORE CANDIDATE CUT! GIVING UP...\n",false);
                    break;
                }
                
            }
 //
 /*
        } while ( !$check_C OR !$check_L );
        
        if ( $check_C AND $check_L ) {
*/
        } while ( $score < $THRESHOLD_SCORE );
        
        if ( $score >= $THRESHOLD_SCORE ) {
//        
            
            //successful assigment
            //save last link
            $greek_eng[] = array(
                    'greekSentIndex' => $greekSentIndex,
                    'candidate' => $candidate,
                    'residual' => $residual,
                    'isAfterFS' => $isAfterFS,
                    'engSentIndex' => $engSentIndex,
                    'candidates_weak_p_cut' => $candidates_weak_p_cut,
                    );
            my_log( "++++++STORED CUTS:\n".print_r($candidates_weak_p_cut,true),false);
            
            //forward
            if ($greekSentIndex<$noGreekSents-1) { 
                $greekSentIndex++;
            } else {
                my_log( "!!!!!!!!! STOP: no more greek sentences !!!!!!!!!!!!\n",false);
                break;
            }
            if ( $residual=='') {
                if ($engSentIndex<$no_sent_eng-1) { 
                    $engSentIndex++;
                } else {
                    my_log( "!!!!!!!!! STOP: no more english sentences !!!!!!!!!!!!\n",false);
                    break;
                }
            }
            
            if (strlen($residual)==0) {
                $candidate=$sent_eng[$engSentIndex];
                $isAfterFS=1; 
            } else {
                $candidate=$residual;
                $isAfterFS=0; 
            }
            $residual='';
            $candidates_weak_p_cut=NULL; 
            $findMore=false;                               
            
            my_log( "****** moving FORWARD *********\n",false);
        
        } else {
            $align_sizes[] = $greekSentIndex;
            //un-successful assigment
            //retrieve first link with any weak cuts
            $findMore=false;
            do {
                $last_link = array_pop($greek_eng);
                
                if ( $last_link ) {
                    $candidates_weak_p_cut = $last_link['candidates_weak_p_cut'];
                    //any weak cuts?
                    if ( !isset($candidates_weak_p_cut) OR
                         ( isset($candidates_weak_p_cut) AND (count($candidates_weak_p_cut) > 0) ) ){
                        $greekSentIndex = $last_link['greekSentIndex'];
                        $candidate = $last_link['candidate'];
                        $residual = $last_link['residual'];
                        $isAfterFS = $last_link['isAfterFS'];
                        $engSentIndex = $last_link['engSentIndex'];
                        $findMore=true;
                    }
                } else {
                    break;
                }
            } while (!$findMore);

            if (!$findMore) {
                my_log( "!!!!!!!!! STOP: no more CHOISES !!!!!!!!!!!!\n",false);
                break;
            }
            my_log( "****** moving BACKWARD *********\n",false);
            //break;
        }
            
        
    } // PARA GREEK SENTS

    if ( ( $greekSentIndex==$noGreekSents-1 ) AND ($engSentIndex==$no_sent_eng-1) ) {
        my_log( "########################## PARA ALIGNED ########################\n",true);
        $para_aligned++;
        reset_log(false);
    } else {
        if ( ($greekSentIndex<$noGreekSents-1) ) {
            $delta=$noGreekSents-1-$greekSentIndex;
            my_log( " para NOT aligned: ".$delta."/".$noGreekSents." GREEK sentences not linked\n",true);
            my_log( " \t max aligned: ".max($align_sizes)."/".$noGreekSents." GREEK sentences not linked\n",true);
            my_log( " \t align sizes: ".print_r($align_sizes,true)."\n",false);
            
        }
        if (  ($engSentIndex<$no_sent_eng-1) ) {
            $delta=$no_sent_eng-1-$engSentIndex;
            my_log( " para NOT aligned: ".$delta."/".$no_sent_eng." ENG sentences not linked\n",true);
        }
        reset_log(true);
    }
    
    $para_count++;
/*    
    if ($para_count==5) {
        break;
    }
*/
} //LOOP PARAS

my_log( "\n\n######  PARA ALIGNED: ".$para_aligned."/".$para_count."  ##################\n",true);


?>
