<?php

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
//errore?

$m=( $l_eng + $l_greek/$c )/2;
$z1=abs( $c*$l_eng - $l_greek ) / sqrt( $s2 * $m );
$pnorm1=stats_cdf_normal( $z1, 0, 1, 1);
$pd1= 2*( 1 - $pnorm1 );

//if ($pd1>0) $res=(-100*log($pd1));

$z=abs( $l_greek - $c*$l_eng ) / sqrt( $s2 * $l_eng );
$pnorm=stats_cdf_normal( $z, 0, 1, 1);
$pd= 2*( 1 - $pnorm );


//if ($pd>0) $res=(-100*log($pd));
$res = array(
            'str_eng' => $s_eng,
            'str_greek' => $s_greek,
            'eng_length'=>$l_eng,
            'greek_length'=>$l_greek,
            'eng_no_caps'=>$l_eng_C,
            'greek_no_caps'=>$l_greek_C,
            'prob'=>$pd,
            'prob1'=>$pd1,
            'log_prob'=>($pd>0)?(-100*log10($pd)):NULL,
            'log_prob1'=>($pd1>0)?(-100*log10($pd1)):NULL
       );

return $res;
}


//CONNECTION
$mysqli = new mysqli("localhost", "root", "hodel_db_PaSsWoRd", "hodel_test");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
$mysqli->set_charset('utf8');


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


$prob_threshold=0.5;
$s2=6.8;  //check other values
/*
$eng="In answer to him spoke swift-footed Achilles:";
$greek="τὸν δ̓ ἀπαμειβόμενος προσέφη πόδας ὠκὺς Ἀχιλλεύς·";
*/
$eng=" \"Flee then, if your heart urges you; I do not beg you to remain for my sake.";
$greek="φεῦγε μάλ̓ εἴ τοι θυμὸς ἐπέσσυται, οὐ δέ σ̓ ἔγωγε λίσσομαι εἵνεκ̓ ἐμεῖο μένειν·";
/*
FleethenifyourhearturgesyouIdonotbegyoutoremainformysake
φεῦγεμάλ̓εἴτοιθυμὸςἐπέσσυταιοὐδέσ̓ἔγωγελίσσομαιεἵνεκ̓ἐμεῖομένειν
*/
$isAfterFS=1;

$res=match_scores($eng,$greek,$c,0,$s2,$isAfterFS);

print_r($res);
echo "MAX(3,3)=".max(3,3)."\n";
$stack = array("orange", "banana");
$stack1 = array("apple", "raspberry");
$stack = array_merge($stack,$stack1);
print_r($stack);
?>
