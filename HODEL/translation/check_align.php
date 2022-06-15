<?php

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

$mysqli = new mysqli("localhost", "root", "hodel_db_PaSsWoRd", "hodel_test");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
$mysqli->set_charset('utf8');

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
            split_sentence($mysqli, $row['ID'], $str1, $str2);
        } else {
            echo "NO CANDIDATE BREAK FOUND!\n";
        }
        break;
    } else {
        echo "\n";
    }
}


?>
