
LOAD DATA LOCAL INFILE 'datafile.csv'
INTO TABLE Forma
(  
  `forma`,
  `lemma`,
  `posAGDT`,
  `pers`,
  `num`,
  `tense`,
  `mood`,
  `voice`,
  `gend`,
  `case`,
  `degree`,
  `afun` ,
  `rank` ,
  `gov` ,
--  `frase` 
  `cite`,  -- perseus cite 
  `subdoc`,
  `id_AGDT`, -- perseus sentence id
  `document_id` -- perseus document id
)
-- ERRORE subdoc,'#',document_id non univoco
-- uso id_AGDT,'#',document_id per compatibiltà, basterebbe id_AGDT
-- SET frase = CONCAT(subdoc,'#',document_id);
SET frase = CONCAT(id_AGDT,'#',document_id);


INSERT INTO Tree 
SELECT f.ID AS forma_id, fP.ID AS parent_id 
FROM Forma AS f LEFT JOIN Forma AS fP
ON( f.frase=fP.frase AND f.gov=fP.rank );

