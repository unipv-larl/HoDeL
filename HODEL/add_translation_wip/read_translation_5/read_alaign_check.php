<?php

// LEGGO file in input
if ( isset($argv[1]) ) {
    $FILENAME=$argv[1];
    //PARSE poem and book from file name
    $content= file_get_contents($FILENAME);
} else {
   print "ERRORE: poem??\n";
   exit;
}

// parso il nome del file
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


//set OUTPUT FILES
$RESFILE="./out/load_alignment_res_".$poem."_".$bookID."_".".txt";
$LOGFILE="./log/load_tmp_log_".$poem."_".$bookID."_".".log";
$ERRFILE="./err/load_align_error_".$poem."_".$bookID."_".".log";
// ... istruzioni SQL  per INSERT
$SQLFILE="./sql/insert_".$poem."_".$bookID."_".".sql";

/* ****************  FUNZIONI *****************/

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

/* ****************  FUNZIONI *****************/


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

echo "NUMERO FRASI: ".$noSents."\n";


    preg_match_all('~'.$enHeader.'~suU', $content, $matchedSents_1, PREG_OFFSET_CAPTURE);
    $NO_en = $matchedSents_1[0];
    $c_en=count($NO_en);
echo "NUMERO HEAD EN: ". $c_en ."\n";

    preg_match_all('~'.$grHeader.'~suU', $content, $matchedSents_2, PREG_OFFSET_CAPTURE);
    $NO_gr = $matchedSents_2[0];
    $c_gr=count($NO_gr);
echo "NUMERO HEAD GR: ". $c_gr ."\n";

    preg_match_all('~'.$grFooter.'~suU', $content, $matchedSents_3, PREG_OFFSET_CAPTURE);
    $NO_GR = $matchedSents_3[0];
    $c_GR=count($NO_GR);
echo "NUMERO FOOT GR: " . $c_GR ."\n";

//    print_r( $NO_GR );

/* */
$i=0;
$cont=-1;
while ($i < $c_GR) {
    
    if  ( ($cont < $NO_en[$i][1] ) AND ( $NO_en[$i][1] < $NO_gr[$i][1] ) AND ( $NO_gr[$i][1] < $NO_GR[$i][1] ) ) {
        echo "EN: " . $NO_en[$i][1] .  " - gr_h: ".$NO_gr[$i][1] .  " - gr_f: ".$NO_GR[$i][1] ."  :: OK ::\n";
    } else {
        echo "EN: " . $NO_en[$i][1] .  " - gr_h: ".$NO_gr[$i][1] .  " - gr_f: ".$NO_GR[$i][1] ."  :: NOK ::\n";
        echo "EN:\n" . $NO_en[$i][0] . "\n";
        echo "gr_h:\n".$NO_gr[$i][0] . "\n";
        echo "gr_f:\n".$NO_GR[$i][0] . "\n";
        exit;
    }
    $cont=$NO_GR[$i][1];
    $i++;
}

while ($i < $c_gr OR $i < $c_en ) {
    
    if ($i < $c_gr) {
        echo "gr_h:\n".$NO_gr[$i][0] . "\n";
    }
    
    if ($i < $c_en) {
        echo "en_h:\n".$NO_en[$i][0] . "\n";
    }
    
    $i++;
    
}



/* */
 
/*    
    print_r( $enSents );
    print_r( $grSents );
*/



?>
