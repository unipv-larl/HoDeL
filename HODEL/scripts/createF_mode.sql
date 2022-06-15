CREATE FUNCTION dcmode (s CHAR(1))
RETURNS CHAR(3) DETERMINISTIC
RETURN  CASE s
 WHEN 'A' THEN "ind" 
 WHEN 'J' THEN  "ind"
 WHEN 'B' THEN "sub" 
 WHEN 'K' THEN  "sub"
 WHEN 'C' THEN "imp" 
 WHEN 'L' THEN  "imp"
 WHEN 'D' THEN "par" 
 WHEN 'M' THEN  "par"
 WHEN 'E' THEN "ger" 
 WHEN 'N' THEN  "ger"
 WHEN 'O' THEN  "ge_"
 WHEN 'G' THEN  "sup"
 WHEN 'P' THEN "sup" 
 WHEN 'H' THEN  "inf"
 WHEN 'Q' THEN "inf" 
 WHEN '-' THEN  NULL
END

