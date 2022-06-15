<?php
/*
'urn:cts:greekLit:tlg0012.tlg001.perseus-grc1'   => 'Iliad',
'urn:cts:greekLit:tlg0012.tlg002.perseus-grc1'   => 'Odyssey'
*/
//     *** INPUT PARAMETERS ***
if ( isset($argv[1]) AND isset($argv[2])  AND isset($argv[3]) ) {
   if ($argv[1] == 1 ) {
       $poemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
       $poem="ILIAD";
   } elseif ($argv[1] == 2 ) {
       $poemID="urn:cts:greekLit:tlg0012.tlg002.perseus-grc1";
       $poem="ODYSSEY";
   } else {
       print "ERRORE: poem??\n";
       exit;
   }
   
   $bookID=$argv[2];
   $doInit=$argv[3];
} else {
$poemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
$poem="ILIAD";
$bookID=1;
$doInit=true;
}
//


//OUTPUT FILES
$RESFILE="./alignment_res_".$poem."_".$bookID."_".".txt";
$LOGFILE="./tmp_log_".$poem."_".$bookID."_".".log";
$ERRFILE="./align_error_".$poem."_".$bookID."_".".log";


//FORMATS
$SEP1="\n----------------------------------------------------------------------\n";
$SEP2="\n======================================================================\n";
$SEP3="\n\n§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§\n";
$SEP4="\n\n########################################################################\n";


function gr_info($str) {
    //filter only letters
    $str_filtered=preg_replace('/[[:digit:][:space:][:punct:]]+/u', '', $str);
    
    //length
    $length=grapheme_strlen($str_filtered);
    
    //count capital letters 
    $str_caps=preg_replace('/[^[:upper:]]+/u', '', $str_filtered);
    $no_caps=grapheme_strlen($str_caps);
    
    $res = array(
                'length'=>$length,
                'no_caps'=>$no_caps,
           );
    
    return $res;
}

function en_info($str, $isAfterFS=false) {
    //filter only letters
    $str_filtered=preg_replace('/[[:digit:][:space:][:punct:]]+/u', '', $str);
    
    //length
    $length=grapheme_strlen($str_filtered);
    
    //count capital letters 
    $str_caps = $isAfterFS ?
                preg_replace('/[^[:upper:]]+/u', '', str_replace('I ','',substr($str,1) )):
                preg_replace('/[^[:upper:]]+/u', '', str_replace('I ','',$str) );         
    $no_caps=grapheme_strlen($str_caps);
    
    $res = array(
                'length'=>$length,
                'no_caps'=>$no_caps,
           );
    
    return $res;
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

function my_log($msg,$echo = false) {
    global $LOGFILE;
    if ($echo) {
        echo $msg;
    }
    error_log($msg, 3, $LOGFILE);
}

function reset_log($store) {
    global $ERRFILE;
    global $LOGFILE;
    if ($store) {
        $curlog = file_get_contents($LOGFILE);
        file_put_contents($ERRFILE, $curlog, FILE_APPEND | LOCK_EX);
    }
    if(file_exists($LOGFILE))
    unlink($LOGFILE);
} 

//CONNECTION
$mysqli = new mysqli("localhost", "root", "hodel_db_PaSsWoRd", "hodel_test");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
$mysqli->set_charset('utf8');


if ($doInit) {
//INIT
$queryC="DROP TABLE IF EXISTS Para_gr_sents";
mysqli_query($mysqli,$queryC);
$queryC="
       CREATE TABLE Para_gr_sents( 
         poem_id VARCHAR(60) NOT NULL,
         book_id int(10) unsigned NOT NULL,
         para_start int(10) unsigned NOT NULL,
         para_end int(10) unsigned NULL,
         sent_start int(10) unsigned NOT NULL,
         sent_end int(10) unsigned NOT NULL,
         sent_id int(10) unsigned NOT NULL,
         sent_gr text NOT NULL DEFAULT '',
         sent_gr_l int(10) unsigned NOT NULL DEFAULT 0,
         PRIMARY KEY (poem_id,book_id,para_start,sent_id)
      )";
db_query($mysqli,$queryC);


$queryC="DROP TABLE IF EXISTS Para_en_sents";
mysqli_query($mysqli,$queryC);
$queryC="
       CREATE TABLE Para_en_sents( 
         poem_id VARCHAR(60) NOT NULL,
         book_id int(10) unsigned NOT NULL,
         para_start int(10) unsigned NOT NULL,
         para_end int(10) unsigned NULL,
         sent_id int(10) unsigned NOT NULL,
         sent_en text NOT NULL DEFAULT '',
         sent_en_l int(10) unsigned NOT NULL DEFAULT 0,
         PRIMARY KEY (poem_id,book_id,para_start,sent_id)
      )";
db_query($mysqli,$queryC);


$queryC="DROP TABLE IF EXISTS Para_en_ms";
mysqli_query($mysqli,$queryC);
$queryC="
       CREATE TABLE Para_en_ms( 
         poem_id VARCHAR(60) NOT NULL,
         book_id int(10) unsigned NOT NULL,
         para_start int(10) unsigned NOT NULL,
         para_end int(10) unsigned NULL,
         ms_start int(10) unsigned NOT NULL,
         ms_end int(10) unsigned NULL,
         ms_en text NOT NULL DEFAULT '',
         ms_en_l int(10) unsigned NOT NULL DEFAULT 0,
         PRIMARY KEY (poem_id,book_id,para_start,ms_start)
      )";
db_query($mysqli,$queryC);

} //inizializzo


//LOOP PARAS
$queryParas="
SELECT book_id, start AS para_start, end AS para_end, eng_para
FROM Book_paras
WHERE poem_id='".$poemID."'".
" AND book_id='".$bookID."'".
//" AND book_id=1 ".
//" AND start IN (312,386,428,458)".
"";
$Paras = db_query($mysqli,$queryParas);
$para_count=0;
$totEnSents=0;
$totGrSents=0;
$totMilestones=0;

reset_log(false);
if(file_exists($RESFILE))
unlink($RESFILE);

$results_header='';


while( $rowParas = mysqli_fetch_array($Paras) ) {
    
    $bookID = $rowParas['book_id'];
    $para_start = $rowParas['para_start'];
    $para_end = is_null($rowParas['para_end'])?"NULL":$rowParas['para_end'];
    
    my_log( "\nprocessing PARA: ".
          " BOOK=".$bookID.
          " START=".$para_start.
          " END=".$para_end . $SEP2, true);

    // ***** OUT RESULTS ********
    //OUT
    $results_header.= $SEP3.
              " BOOK=".$bookID.
              " START=".$para_start.
              " END=".$para_end .$SEP3;
    // ***** OUT RESULTS ********
    

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
    WHERE poem_id='".$poemID."' AND book_id=".$bookID." AND sent_start>=".$para_start
    .$endWhere." 
    GROUP BY sent_id, sent_start, sent_end
    ";   
    $GreekSents = db_query($mysqli,$queryGreekSents);
    $noGrSents=mysqli_num_rows($GreekSents);

    while ( $rowGreekSents=mysqli_fetch_array($GreekSents) ) {
        
        $grSentStart = $rowGreekSents['sent_start'];
        $grSentEnd = $rowGreekSents['sent_end'];
        $grSentID = $rowGreekSents['sent_id'];
        $grSent = $rowGreekSents['sent_greek'];
        $esc_grSent = mysqli_real_escape_string ($mysqli,$grSent);
        $info=gr_info($grSent);
        $grSentL = $info['length'];
        
        $queryI="INSERT INTO Para_gr_sents(
        poem_id, book_id, para_start, para_end, sent_start, sent_end, sent_id, sent_gr, sent_gr_l) 
        VALUES ("."'".$poemID."',".$bookID.",".$para_start.",".$para_end.
        ",".$grSentStart.",".$grSentEnd.",".$grSentID.",'".$esc_grSent."',".$grSentL.")
        ";
        db_query($mysqli,$queryI);
    }


    //EN Sents
    preg_match_all('~([^.?!:]+[.?!:]"?)~',$rowParas['eng_para'],$out);
    $sent_eng=$out[1];
    $noEnSents=count($sent_eng);
    for ($engSentIndex=0; $engSentIndex<$noEnSents; $engSentIndex++) {

        $enSentID = $engSentIndex;
        $enSent = $sent_eng[$engSentIndex];
        $esc_enSent = mysqli_real_escape_string($mysqli,$enSent);
        $info=en_info($enSent);
        $enSentL = $info['length'];

        $queryI="INSERT INTO Para_en_sents(
        poem_id, book_id, para_start, para_end, sent_id, sent_en, sent_en_l) 
        VALUES ("."'".$poemID."',".$bookID.",".$para_start.",".$para_end.
        ",".$enSentID.",'".$esc_enSent."',".$enSentL.")
        ";
        db_query($mysqli,$queryI);
    }


    //EN Milestones
    if ( $para_count>0 ) { //first
        preg_match('~^([^\[]+)~',$rowParas['eng_para'],$mss0);
        $msStart=$para_start;
        $msStr = $mss0[1];
        $init = 0;
    }
    
    preg_match_all('~\[(\d+)\]([^\[]+)~',$rowParas['eng_para'],$mss);
    $milestones= array_unique( array_map('intval', $mss[1]) );
    $milestonesStr= $mss[2];
    $noMilestones = count($milestones);
    
    if ( $para_count==0 ) { //first
        $msStart=$milestones[0];
        $msStr = $milestonesStr[0];
        $init = 1;
    }

    for ($ms_i= $init; $ms_i<$noMilestones; $ms_i++) {

        $msEnd = $milestones[$ms_i];
        $esc_msStr = mysqli_real_escape_string($mysqli,$msStr);
        $info=en_info($msStr);
        $msL = $info['length'];

        $queryI="INSERT INTO Para_en_ms(
        poem_id, book_id, para_start, para_end, ms_start, ms_end, ms_en, ms_en_l) 
        VALUES ("."'".$poemID."',".$bookID.",".$para_start.",".$para_end.
        ",".$msStart.",".$msEnd.",'".$esc_msStr."',".$msL.")
        ";
        db_query($mysqli,$queryI);
        
        $msStr = $milestonesStr[$ms_i];
        $msStart = $msEnd + 1;
    }
 
    //finalize
    if ( ($para_end % 5) >0 ) {
        $msEnd = $para_end;
        $esc_msStr = mysqli_real_escape_string($mysqli,$msStr);
        $info=en_info($msStr);
        $msL = $info['length'];
    
        $queryI="INSERT INTO Para_en_ms(
        poem_id, book_id, para_start, para_end, ms_start, ms_end, ms_en, ms_en_l) 
        VALUES ("."'".$poemID."',".$bookID.",".$para_start.",".$para_end.
        ",".$msStart.",".$msEnd.",'".$esc_msStr."',".$msL.")
        ";
        db_query($mysqli,$queryI);
    }


    my_log( " NO_ENG_SENTS=".$noEnSents." NO_ENG_MILESTONES=".$noMilestones.
          " NO_GREEK_SENTS=".$noGrSents.$SEP2,true);
    
    $para_count++;
    $totEnSents+=$noEnSents;
    $totMilestones+=$noMilestones;
    $totGrSents+=$noGrSents;

} //LOOP PARAS

my_log( $SEP4.
        "\tPROCESSED PARAS:\t".$para_count."\n".
        "\tEN SENTS:\t".$totEnSents."\n".
        "\tEN MILESTONES:\t".$totMilestones."\n".
        "\tGR SENTS:\t".$totGrSents.
        $SEP4,true);


?>
