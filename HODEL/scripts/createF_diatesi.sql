DELIMITER $$

DROP FUNCTION IF EXISTS diatesi$$

CREATE FUNCTION diatesi (modo CHAR(1), lemma CHAR(30))
RETURNS CHAR(1) DETERMINISTIC

BEGIN

RETURN   IF (modo IN('A', 'B', 'C', 'D', 'E', 'G', 'H'), 
      "A", 
      if (modo in ('J','K','L','M','N','O','P','Q'),
         if( lemma like '%r',
            "A", 
            "P"),
         NULL) 
   );
END $$

DELIMITER ;

