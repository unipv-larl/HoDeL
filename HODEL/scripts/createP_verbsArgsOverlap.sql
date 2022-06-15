DELIMITER $$

DROP PROCEDURE IF EXISTS verbsArgsOverlap $$
CREATE PROCEDURE verbsArgsOverlap ( targetRelation CHAR(10) )
BEGIN
DECLARE nonCompleti INT DEFAULT 0;

DROP TABLE IF EXISTS _VerbArg;
CREATE TABLE `_VerbArg` (
  `root_id` int(11) unsigned DEFAULT NULL,
  `trueTarget` int(11) unsigned DEFAULT NULL,
  `lab` text,
  `mn` int(20) unsigned DEFAULT NULL,
  `mx` int(20) unsigned DEFAULT NULL,
  KEY `root_id` (`root_id`),
  KEY `trueTarget` (`trueTarget`)
);

IF targetRelation IS NOT NULL THEN 
   INSERT INTO _VerbArg 
   SELECT root_id, trueTarget, lab, mn, mx  FROM VerbArg WHERE lab=targetRelation OR lab='V';
ELSE 
   INSERT INTO _VerbArg 
   SELECT root_id, trueTarget, lab, mn, mx FROM VerbArg;
END IF;

DROP TABLE IF EXISTS t0;
CREATE TABLE t0
SELECT t1.*, t2.trueTarget AS covTrueTarget, t2.lab AS covLab, t2.mn AS covMn, t2.mx AS covMx
FROM _VerbArg t1 JOIN _VerbArg t2 ON( t1.root_id=t2.root_id AND t2.mn > t1.mn AND t2.mn<t1.mx  );

SELECT COUNT(*) INTO nonCompleti FROM t0;

IF nonCompleti > 0 THEN

DROP TABLE IF EXISTS ti;
CREATE TABLE ti LIKE t0;

DROP TABLE IF EXISTS ti1;
CREATE TABLE ti1 LIKE t0;
INSERT INTO ti1
SELECT * FROM t0;

ALTER TABLE t0 ADD INDEX (root_id), ADD INDEX(trueTarget), ADD INDEX(covTrueTarget);
 
END IF;

WHILE nonCompleti > 0 DO

TRUNCATE ti;
INSERT INTO ti
SELECT l.root_id, l.trueTarget, l.lab, l.mn, l.mx, r.covTrueTarget, r.covLab, r.covMn, r.covMx
FROM ti1 l JOIN ti1 r ON( l.covTrueTarget=r.trueTarget AND l.covTrueTarget <> l.trueTarget );

SELECT COUNT(*) INTO nonCompleti FROM ti;

INSERT INTO t0 
SELECT * FROM ti;

TRUNCATE ti1;
INSERT INTO ti1 
SELECT * FROM ti;

END WHILE;

DELETE _VerbArg.* 
FROM _VerbArg JOIN t0 ON ( _VerbArg.trueTarget = t0.covTrueTarget);

UPDATE _VerbArg JOIN ( 
                SELECT root_id, trueTarget, lab, mn, mx, GROUP_CONCAT( covLab ORDER BY covMn SEPARATOR '+' ) AS cLab, MIN(covMn) AS cMn, MAX(covMx) AS cMx
                FROM t0 
                GROUP BY root_id, trueTarget ) t1
ON ( _VerbArg.root_id = t1.root_id AND _VerbArg.trueTarget=t1.trueTarget )
SET _VerbArg.lab=CONCAT(_VerbArg.lab,'+', cLab), _VerbArg.mn=IF(cMn < _VerbArg.mn, cMn, _VerbArg.mn ), _VerbArg.mx=IF(cMx > _VerbArg.mx, cMx, _VerbArg.mx);


IF targetRelation  IS NOT NULL  THEN 
SET @Query=CONCAT("ALTER TABLE VerbArg ADD COLUMN lab_", targetRelation, " text DEFAULT NULL, ",
"ADD COLUMN mn_", targetRelation, " int(11) unsigned DEFAULT NULL, ", 
"ADD COLUMN mx_", targetRelation, " int(11) unsigned DEFAULT NULL" );
PREPARE stmt FROM @Query;
EXECUTE stmt;

SET @Query=CONCAT("UPDATE VerbArg va, _VerbArg tva "  
   "SET  va.lab_", targetRelation, "=tva.lab, ", 
          "va.mn_", targetRelation, "=tva.mn, ", 
          "va.mx_", targetRelation, "=tva.mx ",
   "WHERE va.root_id=tva.root_id AND va.trueTarget=tva.trueTarget" );
PREPARE stmt FROM @Query;
EXECUTE stmt;

DEALLOCATE PREPARE stmt;
ELSE 
   ALTER TABLE VerbArg ADD COLUMN lab_All text DEFAULT NULL, 
                       ADD COLUMN mn_All int(11) unsigned DEFAULT NULL, 
                       ADD COLUMN mx_All int(11) unsigned DEFAULT NULL;
   UPDATE VerbArg va, _VerbArg tva   
   SET  va.lab_All=tva.lab, va.mn_All=tva.mn, va.mx_All=tva.mx
   WHERE va.root_id=tva.root_id AND va.trueTarget=tva.trueTarget;
END IF;

DROP TABLE IF EXISTS t0;
DROP TABLE IF EXISTS ti;
DROP TABLE IF EXISTS ti1;
DROP TABLE IF EXISTS _VerbArg;

END$$

DELIMITER ;
