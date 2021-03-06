CREATE FUNCTION eccase (s CHAR(3))
RETURNS CHAR(3) DETERMINISTIC

RETURN  CASE s
 WHEN "nom" THEN 'A,J' 
 WHEN "gen" THEN 'B,K' 
 WHEN "dat" THEN 'C,L' 
 WHEN "acc" THEN 'D,M' 
 WHEN "voc" THEN 'E,N' 
 WHEN "abl" THEN 'F,O' 
 WHEN "adv" THEN 'G' 
 WHEN NULL  THEN '-' 
END

