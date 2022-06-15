DELIMITER $$

DROP PROCEDURE IF EXISTS initFindPath $$
CREATE PROCEDURE initFindPath (
RootTN VARCHAR(50), TargetTN VARCHAR(50), IntTN VARCHAR(50)
)
BEGIN

-- Crea ed inizilizza le tabelle di supporto 
CREATE TABLE IF NOT EXISTS _Path (
--  root_id int(10) unsigned NOT NULL default '0',
  root_id int(10) unsigned default '0',
  target_id int(10) unsigned NOT NULL default '0',
  parent_id int(10) unsigned default '0',
  depth int(10) unsigned NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
TRUNCATE _Path;

CREATE TABLE IF NOT EXISTS _nuoviNodi LIKE _Path;

CREATE TABLE IF NOT EXISTS _Target LIKE Forma;
TRUNCATE _Target;
CREATE TABLE IF NOT EXISTS _Root LIKE Forma;
TRUNCATE _Root;
CREATE TABLE IF NOT EXISTS _InPath LIKE Forma;
TRUNCATE _InPath;

SET @Query=CONCAT("INSERT INTO _Root SELECT * FROM ", RootTN );
PREPARE stmt FROM @Query;
EXECUTE stmt;

SET @Query=CONCAT("INSERT INTO _Target SELECT * FROM ", TargetTN );
PREPARE stmt FROM @Query;
EXECUTE stmt;

SET @Query=CONCAT("INSERT INTO _InPath SELECT * FROM ", IntTN );
PREPARE stmt FROM @Query;
EXECUTE stmt;

DEALLOCATE PREPARE stmt;

END$$

DELIMITER ;
