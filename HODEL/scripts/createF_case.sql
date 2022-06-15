CREATE FUNCTION dccase (s CHAR(1))
RETURNS CHAR(3) DETERMINISTIC

RETURN  CASE s
 WHEN 'A' THEN "nom" 
 WHEN 'J' THEN  "nom"
 WHEN 'B' THEN "gen" 
 WHEN 'K' THEN  "gen"
 WHEN 'C' THEN "dat" 
 WHEN 'L' THEN  "dat"
 WHEN 'D' THEN "acc" 
 WHEN 'M' THEN  "acc"
 WHEN 'E' THEN "voc" 
 WHEN 'N' THEN  "voc"
 WHEN 'F' THEN "abl" 
 WHEN 'O' THEN  "abl"
 WHEN 'G' THEN  "adv"
 WHEN '-' THEN  NULL
END

