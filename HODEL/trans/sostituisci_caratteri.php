<?php

$in_file = 'lista_forme_lemmi_all.txt';
$out_file = 'lista_forme_lemmi_all.trans.txt';
$in_file_contents = file_get_contents($in_file);
$out_file_contents = $in_file_contents;



$tab = "\t";

$fp = fopen('lista_caratteri_traslitterazione.sorted.txt', 'r');
$i = 1;
while ( !feof($fp) )
{
    $line = fgets($fp, 2048);

    $data_txt = str_getcsv($line, $tab);

    //Get First Line of Data over here
    if ($data_txt[0]) {
      print "$i: GREEK( ". $data_txt[0] . " ) ---> TRANS( ". $data_txt[1] ." )\n";
      $out_file_contents = str_replace( "$data_txt[0]", "$data_txt[1]", $out_file_contents );
      $i++;
   }
}                              

fclose($fp);

file_put_contents($out_file,$out_file_contents);

?>
