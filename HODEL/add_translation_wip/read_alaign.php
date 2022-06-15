<?php

if ( isset($argv[1]) ) {
    $FILENAME=$argv[1];
    //PARSE poem and book from file name
    $content= file_get_contents($FILENAME);
} else {
   print "ERRORE: poem??\n";
   exit;
}

        preg_match_all('~_(ILIAD|ODYSSEY)_(\d+)_~',$FILENAME,$poem_book);
        
        $poem=$poem_book[1][0];
        $bookID=$poem_book[2][0];

if ( isset($poem) AND isset($bookID) )  {
   if ( $poem == "ILIAD" ) {
       $poemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
   } elseif ( $poem == "ODYSSEY" ) {
       $poemID="urn:cts:greekLit:tlg0012.tlg002.perseus-grc1";
   } else {
       print "ERRORE: poem??\n";
       exit;
   }
} else {
    print "ERRORE: FILENAME??\n";
    exit;
}


//OUTPUT FILES
$RESFILE="./out/load_alignment_res_".$poem."_".$bookID."_".".txt";
$LOGFILE="./log/load_tmp_log_".$poem."_".$bookID."_".".log";
$ERRFILE="./err/load_align_error_".$poem."_".$bookID."_".".log";

$SQLFILE="./sql/insert_".$poem."_".$bookID."_".".sql";


function db_query($conn,$query,$savequery = false){
    global $SQLFILE;
    $queryRes=mysqli_query($conn,$query);
    if (!$queryRes ) {
        echo "DB ERROR\n";
        echo "MySQL: (" . mysqli_errno($conn) . ") " . mysqli_error($conn)."\n";
        echo "QUERY(".$query.")\n";
        exit;
    } 
    if ($savequery) {
        file_put_contents($SQLFILE, $query, FILE_APPEND | LOCK_EX);
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
$mysqli = new mysqli("localhost", "hodel_user", "hodel", "hodel_test");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
$mysqli->set_charset('utf8');


reset_log(false);
if(file_exists($RESFILE))
unlink($RESFILE);
if(file_exists($SQLFILE))
unlink($SQLFILE);



// match saltati + correzione match gr
/*
    $enHeader="={3,}\n.*\n={3,}\n";
    $grHeader="-{3,}\n.*\n-{3,}\n";
    $grFooter="#{3,}\n";
    preg_match_all('~'.$enHeader.'(.*)\n'.$grHeader.'([^#]*)\n'.$grFooter.'~u', $content, $matchedSents);
*/
    $enHeader="\s*={3,}\s*\n.*\n\s*={3,}\s*\n";
    $grHeader="\s*-{3,}\s*\n.*\n\s*-{3,}\s*\n";
    $grFooter="\s*#{3,}\s*\n";
    preg_match_all('~'.$enHeader.'(.*)\n'.$grHeader.'(.*)\n'.$grFooter.'~suU', $content, $matchedSents);
//

    $enSents = $matchedSents[1];
    $grSents= $matchedSents[2];
    $noSents = count($enSents);
 
/*    
    print_r( $enSents );
    print_r( $grSents );
*/

        $queryI="INSERT INTO temp_align(
        poem_id, book_id, sent_start, sent_end, sent_en) 
        VALUES \n";

    $first=true;
    for (  $s=0; $s<$noSents; $s++) {
        $_enS = $enSents[$s];
        $grS  = $grSents[$s];
        //filtro ms
        $enS = preg_replace('/\[[[:digit:][:space:]]+\]/u', '', $_enS);
        preg_match_all('~\[(\d+),(\d+)\]~',$grS,$m_grSentsRefs);
        
        $grSstarRefs=$m_grSentsRefs[1];
        $grSendRefs=$m_grSentsRefs[2];

        $noGrRefs = count($grSstarRefs);
        
/*
        print_r($grSstarRefs);
        print_r($grSendRefs);
*/
        for (  $r=0; $r<$noGrRefs; $r++) {
            /*
            print("\"".$_enS."\"\n");
            print("(".$grSstarRefs[$r].",".$grSendRefs[$r].")\n");
            */
            $esc_enSent = mysqli_real_escape_string ($mysqli,$enS);
            if ($first) {
                $first=false;
            } else {
                $queryI.=",\n";
            }
            $queryI.="('".$poemID."',".$bookID.",".$grSstarRefs[$r].",".$grSendRefs[$r].",'".$esc_enSent."')";
        }

    }
    
    $queryI.=";\n";

//CREA E POPOLA TABELLA TABELLA DI APPOGGIO
$queryC="DROP TABLE IF EXISTS temp_align;\n";
db_query($mysqli,$queryC, true);
$queryC="
       CREATE TABLE temp_align( 
         poem_id VARCHAR(60) NOT NULL,
         book_id int(10) unsigned NOT NULL,
         sent_start int(10) unsigned NOT NULL,
         sent_end int(10) unsigned NOT NULL,
         sent_en text NOT NULL DEFAULT '',
         KEY (poem_id,book_id,sent_start,sent_end)
      );\n";
db_query($mysqli,$queryC, true);
db_query($mysqli,$queryI, true);

$queryR="REPLACE INTO Sentence_Translation 
         SELECT sent_id, sent_en 
         FROM Para_gr_sents 
         INNER JOIN temp_align 
         USING(poem_id,book_id,sent_start,sent_end);
         ";
db_query($mysqli,$queryR, true);

?>
