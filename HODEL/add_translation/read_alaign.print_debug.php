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
$RESFILE="./load_alignment_res_".$poem."_".$bookID."_".".txt";
$LOGFILE="./load_tmp_log_".$poem."_".$bookID."_".".log";
$ERRFILE="./load_align_error_".$poem."_".$bookID."_".".log";



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


reset_log(false);
if(file_exists($RESFILE))
unlink($RESFILE);



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
 
/**/
    print_r( $enSents );
    print_r( $grSents );
    print_r( $noSents );
/**/

        $queryI="INSERT INTO temp_align(
        poem_id, book_id, sent_start, sent_end, sent_en) 
        VALUES ";

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
                $queryI.=",";
            }
            $queryI.="('".$poemID."',".$bookID.",".$grSstarRefs[$r].",".$grSendRefs[$r].",'".$esc_enSent."')";
        }

    }
/*
//CREA E POPOLA TABELLA TABELLA DI APPOGGIO
$queryC="DROP TABLE IF EXISTS temp_align";
mysqli_query($mysqli,$queryC);
$queryC="
       CREATE TABLE temp_align( 
         poem_id VARCHAR(60) NOT NULL,
         book_id int(10) unsigned NOT NULL,
         sent_start int(10) unsigned NOT NULL,
         sent_end int(10) unsigned NOT NULL,
         sent_en text NOT NULL DEFAULT '',
         KEY (poem_id,book_id,sent_start,sent_end)
      )";
db_query($mysqli,$queryC);
db_query($mysqli,$queryI);

$queryR="REPLACE INTO Sentence_Translation 
         SELECT sent_id, sent_en 
         FROM Para_gr_sents 
         INNER JOIN temp_align 
         USING(poem_id,book_id,sent_start,sent_end)
         ";
db_query($mysqli,$queryR);
*/
//echo "QUERY(\n".$queryI."\n)\n";
?>
