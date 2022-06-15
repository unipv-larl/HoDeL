CREATE FUNCTION dcmode (s CHAR(1))
RETURNS CHAR(3) DETERMINISTIC
RETURN  CASE s
 WHEN 'i' THEN "ind" 
 WHEN 's' THEN "sub" 
 WHEN 'n' THEN "inf"
 WHEN 'm' THEN "imp" 
 WHEN 'p' THEN "par" 
 WHEN 'o' THEN "opt" 
 WHEN '-' THEN  NULL
END
