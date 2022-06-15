DELIMITER $$

DROP PROCEDURE IF EXISTS finFindPath $$
CREATE PROCEDURE finFindPath (PathTN VARCHAR(50))
BEGIN
-- copia la tabella dei _Path nella tabella indicata
SET @Query=CONCAT("DROP TABLE IF EXISTS ", PathTN);
PREPARE stmt FROM @Query;
EXECUTE stmt;

SET @Query=CONCAT("CREATE TABLE ", PathTN, " LIKE _Path");
PREPARE stmt FROM @Query;
EXECUTE stmt;

SET @Query=CONCAT("INSERT INTO ", PathTN, " SELECT * FROM _Path");
PREPARE stmt FROM @Query;
EXECUTE stmt;

-- elimina tabelle di supporto (compresa '_Path')
DROP TABLE _Path;
DROP TABLE _Root;
DROP TABLE _Target;
DROP TABLE _InPath;
DROP TABLE _nuoviNodi;

DEALLOCATE PREPARE stmt;

END$$

DELIMITER ;
