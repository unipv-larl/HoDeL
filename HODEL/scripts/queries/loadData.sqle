
LOAD DATA LOCAL INFILE 'datafile.csv'
INTO TABLE Forma
(  
  `forma`,
  `lemma`,
  `pos`,
  `grado_nom`,
  `cat_fl`,
  `modo` ,
  `tempo` ,
  `grado_part` ,
  `caso` ,
  `gen_num` ,
  `comp` ,
  `variaz` ,
  `variaz_graf` ,
  `afun` ,
  `rank` ,
  `gov` ,
  `frase` 
);


INSERT INTO Tree 
SELECT f.ID AS forma_id, fP.ID AS parent_id 
FROM Forma AS f LEFT JOIN Forma AS fP
ON( f.frase=fP.frase AND f.gov=fP.rank );

