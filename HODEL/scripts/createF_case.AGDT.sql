CREATE FUNCTION dccase (s CHAR(1))
RETURNS CHAR(3) DETERMINISTIC

RETURN  CASE s
 WHEN 'n' THEN "nom" 
 WHEN 'g' THEN "gen" 
 WHEN 'd' THEN "dat" 
 WHEN 'a' THEN "acc" 
 WHEN 'v' THEN "voc" 
 WHEN '-' THEN  NULL
END
