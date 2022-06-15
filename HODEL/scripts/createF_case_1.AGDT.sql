CREATE FUNCTION eccase (s CHAR(3))
RETURNS CHAR(3) DETERMINISTIC

RETURN  CASE s
 WHEN "nom" THEN 'n' 
 WHEN "gen" THEN 'g' 
 WHEN "dat" THEN 'd' 
 WHEN "acc" THEN 'a' 
 WHEN "voc" THEN 'v' 
 WHEN NULL  THEN '-' 
END

