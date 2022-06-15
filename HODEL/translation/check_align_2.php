<?php


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
 eng_book_l, POW(CAST(greek_book_l AS SIGNED) - CAST(eng_book_l AS SIGNED),2) AS sd 
FROM Book_stats
ORDER BY eng_book_l ASC
";

$result = $conn->query($get_stats);
$x=array();
$y=array();
while($row = $result->fetch_array())
{
    $x[]=$row['eng_book_l'];
    $y[]=$row['sd'];
}

var_dump($x);
var_dump($y);
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


/* Returns the area under a normal distribution
   from -inf to z standard deviations */
function pnorm($z) {
  $t = 1/(1 + 0.2316419 * $z);
  $pd = 1 - 0.3989423 * 
    exp(-$z * $z/2) *
    ((((1.330274429 * $t - 1.821255978) * $t
       + 1.781477937) * $t - 0.356563782) * $t + 0.319381530) * $t;
  /* see Abramowitz, M., and I. Stegun (1964), 26.2.17 p. 932 */
  return($pd);
}


function match_score($str_eng,$str_greek, $c, $s, $s2) {
//strings
$s_eng=preg_replace('/[[:digit:][:space:][:punct:]]+/u', '', $str_eng);
$s_greek=preg_replace('/[[:digit:][:space:][:punct:]]+/u', '', $str_greek);
//length
$l_eng=grapheme_strlen($s_eng);
$l_greek=grapheme_strlen($s_greek);
//count upper - filtra I per l'inglese 
$s_eng_C=preg_replace('/[^[:upper:]]+/u', '', substr($s_eng,1));
$s_greek_C=preg_replace('/[^[:upper:]]+/u', '', $s_greek);
$l_eng_C=grapheme_strlen($s_eng_C);
$l_greek_C=grapheme_strlen($s_greek_C);

//$c=1;
//$s2=6.8;
$s2=5.6;
//errore?
/*
$m=( $l_eng + $l_greek/$c )/2;
$z=abs( $c*$l_eng - $l_greek ) / sqrt( $s2 * $c );
$pnorm=stats_cdf_normal( $z, 0, 1, 1);
$pnorm_1=pnorm($z);
$pd= 2*( 1 - $pnorm );

if ($pd>0) $res=(-100*log($pd));
*/
$z=abs( $l_greek - $c*$l_eng ) / sqrt( $s2 * $l_eng );
$pnorm=stats_cdf_normal( $z, 0, 1, 1);
$pnorm_1=pnorm($z);
$pd= 2*( 1 - $pnorm );

if ($pd>0) $res=(-100*log($pd));
//

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++\nSCORES:\n";
echo "****ENG(".$s_eng.")\n";
echo "****GREEK(".$s_greek.")\n";
echo "****ENG_LENGTH(".$l_eng.")\n";
echo "****GREEK_LENGTH(".$l_greek.")\n";
echo "****ENG(".$s_eng_C.")\n";
echo "****GREEK(".$s_greek_C.")\n";
echo "****ENG_LENGTH(".$l_eng_C.")\n";
echo "****GREEK_LENGTH(".$l_greek_C.")\n";
//echo "m=".$m."\n";
echo "z=".$z."\n";
echo "pnorm=".$pnorm."\n";
echo "pnorm_1=".$pnorm_1."\n";
echo "pd=".$pd."\n";
if (isset($res))
   echo "\n>>>>>MAIN_SCORE(".$res.")<<<<<\n\n";
else 
   echo "\n>>>>>MAIN_SCORE(UNDEFINED!!!!)<<<<<\n\n";
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n";
}

function split_sentence($conn,$ID,$str1,$str2) {
$ID_1=1+$ID;
$query=
"UPDATE Sentence_eng 
    SET ID = ID+1 
WHERE  ID > ". $ID . "
ORDER BY ID DESC;
UPDATE Sentence_eng 
    SET sent = '". $str1 . "'
WHERE  ID = ". $ID . ";
INSERT INTO Sentence_eng(ID,sent)
VALUES (" . $ID_1 . ", '" . $str2 . "');
";
//    echo "QUERY(\n" . $query . "\n)\n";

if ( $conn->multi_query($query) ) {
    echo "SUCCESSFULLY SPLIT\n";
} else {
    echo "SPLIT FAILED\n";
    echo("Error description: " . mysqli_error($conn)). "\n";
    echo "QUERY(\n" . $query . "\n)\n";
}

}



//CONNECTION

$mysqli = new mysqli("localhost", "root", "PaShalom", "hodel_test");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
$mysqli->set_charset('utf8');



// STAT PARAMS
$query_stat="
SELECT poem_id, 
       AVG(greek_book_l/eng_book_l) AS c,
       STD(greek_book_l/eng_book_l) AS s, 
       VARIANCE(greek_book_l/eng_book_l) AS s2 
FROM Book_stats 
WHERE poem_id='urn:cts:greekLit:tlg0012.tlg001.perseus-grc1'
GROUP BY poem_id
";

$result = $mysqli->query($query_stat);

$row = $result->fetch_array();

$c=$row['c'];
$s=$row['s'];
$s2=$row['s2'];

//$res=linear_regression($mysqli);


echo "--------STATS PARAMS-----------\n";
echo "c=".$c."\n";
echo "s=".$s."\n";
echo "s2=".$s2."\n";
//echo "linear regression: m=(".$res['m']."); b=(".$res['b'].")\n";
echo "-------------------------------\n";

//CURRENT ALIGNMENT
$get_align=
"SELECT ID, `start`, `end`, Sentence_greek.sent AS greek, Sentence_eng.sent AS eng
FROM Sentence_greek 
LEFT JOIN Sentence_eng
USING(ID)
ORDER BY ID
";

$result = $mysqli->query($get_align);

while($row = $result->fetch_array())
{
    echo "=======================================================\n";
    echo "ID=". $row['ID'] . "  FROM: ". $row['start'] ."  TO: ". $row['end'] ."\n";
    echo "GREEK:\n".$row['greek']."\n";
    echo "-------------------------------------------------------\n";
    echo "ENGLISH:\n".$row['eng']."\n";
    
    //SCORES
    match_score($row['eng'], $row['greek'], $c, $s, $s2);
   
    preg_match_all('~\[(\d+)\]~',$row['eng'],$out);
    $milestones= array_unique( array_map('intval', $out[1]) );
    //var_dump($milestones);
    $check="ok";
    $position=0;
    $offending_milestone='';
    foreach ($milestones as $m){
        if ( $m>$row['end'] ) {
            $check="NOK!!!!";
            $position=$m;
            break;
        }
    }
    echo "check: ".$check;
    if ($check!='ok') {
        $offending_milestone = "[".$position."]";
        echo " OFFENDING MILESTONE: ".$offending_milestone."\n";
        //posizione del milestone
        $pos = strpos($row['eng'],$offending_milestone);
        $break_offset = $pos - strlen($row['eng']);
        $break_pos = strrpos($row['eng'],';',$break_offset);
        if ( $break_pos !== false )
        {
            $str1 = trim( substr($row['eng'],0,$break_pos+1) );
            $str2 = trim( substr($row['eng'],$break_pos + 1) );
            echo "CANDIDATE BREAK <<<".$str1.">>>\n<<<".$str2.">>>\n";
//            split_sentence($mysqli, $row['ID'], $str1, $str2);
        } else {
            echo "NO CANDIDATE BREAK FOUND!\n";
        }
        break;
    } else {
        echo "\n";
    }
}


?>
