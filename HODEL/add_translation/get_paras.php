<?php
/*
//ILIAD
$poemXML="Perseus_text_1999.01.0134.xml";
$pemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
//ODYSSEY

*/
//     *** INPUT PARAMETERS ***
if ( isset($argv[1]) AND isset($argv[2])) {
   if ($argv[1] == 1 ) {
       $poemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
       $poemXML="Perseus_text_1999.01.0134.xml";
       $poem="ILIAD";
   } elseif ($argv[1] == 2 ) {
       $poemID="urn:cts:greekLit:tlg0012.tlg002.perseus-grc1";
       $poemXML="Perseus_text_1999.01.0136.xml";
       $poem="ODYSSEY";
   } else {
       print "ERRORE: poem??\n";
       exit;
   }
   
   $doInit=$argv[2];
} else {
$poemID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
$poemXML="Perseus_text_1999.01.0134.xml";
$poem="ILIAD";
$doInit=true;
}
//


//CONNECTION
$mysqli = new mysqli("localhost", "root", "hodel_db_PaSsWoRd", "hodel_test");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
$mysqli->set_charset('utf8');

if ($doInit) {
    //INIZAILIZZO
$queryC="DROP TABLE IF EXISTS Book_paras";
mysqli_query($mysqli,$queryC);
$queryC="
       CREATE TABLE Book_paras( 
         poem_id VARCHAR(60) NOT NULL,
         book_id int(10) unsigned NOT NULL,
         start int(10) unsigned NOT NULL,
         end int(10) unsigned NULL,
         eng_para text,
         eng_para_l int(10) unsigned NOT NULL DEFAULT 0,
         greek_para_l int(10) unsigned NOT NULL DEFAULT 0,
         PRIMARY KEY (poem_id,book_id,start)
      )";
if (!mysqli_query($mysqli,$queryC) ) {
    echo "DB ERROR\n";
    echo "MySQL: (" . mysqli_errno($mysqli) . ") " . mysqli_error($mysqli)."\n";
    echo "QUERY(".$queryC.")\n";
    exit;
} else {
    echo "TABLE Book_paras CREATED\n";
}

}//init

$queryI="INSERT INTO Book_paras(poem_id,book_id,start,eng_para,eng_para_l) VALUES";

/*
//ILIAD
$iliadXML="Perseus_text_1999.01.0134.xml";
$iliadID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1";
*/

for ($book=1; $book<=24; $book++) {
    $output = shell_exec('xsltproc --param book '.$book.' prova_with_milestones_2.xsl '.$poemXML);
    //echo "OUTPUT(".$output.")\n"
    preg_match_all('~{(\d+)}([^{]+)~', $output, $out, PREG_PATTERN_ORDER);
    $para_starts=$out[1];
    $paras=$out[2];
    //var_dump($para_starts);
    //var_dump($paras);
    for ($i=0; $i<count($paras); $i++) {
        
        if ($i > 0 ) {
            $end=0+$para_starts[$i]-1;
            $queryU="UPDATE Book_paras SET end=".$end.
                    " WHERE poem_id='".$poemID."' AND book_id=".$book." AND start=".$para_starts[$i-1];
            if (!mysqli_query($mysqli,$queryU) ) {
                echo "DB ERROR\n";
                echo "MySQL: (" . mysqli_errno($mysqli) . ") " . mysqli_error($mysqli)."\n";
                echo "QUERY(".$queryU.")\n";
                exit;
            }
        }
        
        $para = mysqli_real_escape_string( $mysqli, $paras[$i]);
        $s_para=preg_replace('/[[:digit:][:space:][:punct:]]+/u', '', $paras[$i]);
        $l_para=grapheme_strlen($s_para);
        
        $qI = $queryI." (".
                    "'". $poemID ."', ". $book. ", ".$para_starts[$i].", '".$para."', ".$l_para
                   .")";
        if (!mysqli_query($mysqli,$qI) ) {
            echo "DB ERROR\n";
            echo "MySQL: (" . mysqli_errno($mysqli) . ") " . mysqli_error($mysqli)."\n";
            echo "QUERY(".$qI.")\n";
            exit;
        } else {
            echo "inserted PARA start=".$para_starts[$i]."; length=".$l_para."\n";
        }
    }        
}

//GREEK 
//nb:check boundaries   
$queryPop_greek="
UPDATE Book_paras NATURAL JOIN
(
SELECT P.poem_id,P.book_id,P.start,
       MIN(sent_start) AS sent_start, MAX(sent_end) AS sent_end, SUM( CHAR_LENGTH(forma) ) AS para_l  
FROM Book_paras P
INNER JOIN ( 
       SELECT document_id AS poem_id, 
       CAST( SUBSTRING_INDEX(subdoc,'.',1)  AS UNSIGNED) AS book_id,
       CAST( SUBSTRING_INDEX( SUBSTRING_INDEX(subdoc,'-',1),'.',-1)  AS UNSIGNED) sent_start, 
       CAST( SUBSTRING_INDEX( SUBSTRING_INDEX(subdoc,'-',-1),'.',-1)  AS UNSIGNED)  sent_end,
       forma
       FROM Sentence 
       INNER JOIN Forma
            ON (frase=Sentence.id)
       WHERE posAGDT<>'u'
      ) G 
ON( P.poem_id=G.poem_id AND P.book_id=G.book_id AND sent_start>=start AND ( end IS NULL OR sent_end<=end ) )
GROUP BY P.poem_id,P.book_id,P.start
) GP
SET greek_para_l=para_l
";

if (!mysqli_query($mysqli,$queryPop_greek) ) {
    echo "DB ERROR\n";
    echo "MySQL: (" . mysqli_errno($mysqli) . ") " . mysqli_error($mysqli)."\n";
    echo "QUERY(".$queryPop_greek.")\n";
    exit;
} else {
    echo "UPDATED greek para length\n";
}

?>
