
-- tabella degli argomenti per ciascun verbo
-- comprende il verbo medisimo...
DROP TABLE IF EXISTS VerbArg;
CREATE TABLE VerbArg
        (
         SELECT pl.root_id, IF(tc.target_id IS NULL, pl.target_id, tc.coord_id) AS trueTarget, 
                GROUP_CONCAT( 
                   DISTINCT TRIM( TRAILING '_Ap' FROM  TRIM(TRAILING '_Co' FROM ft.afun ) ) 
                   ORDER BY TRIM( TRAILING '_Ap' FROM  TRIM(TRAILING '_Co' FROM ft.afun ) )
                )AS lab, MIN(ft.rank) AS mn, MAX(ft.rank) AS mx
         FROM
             TargetRoot pl 
             LEFT JOIN TargetCoord tc ON (tc.target_id=pl.target_id), Forma ft
             WHERE pl.target_id=ft.ID 
         GROUP BY pl.root_id, trueTarget
         ) UNION (
         SELECT pl.root_id, pl.root_id, 'V', ft.rank, ft.rank 
         FROM
             TargetRoot pl JOIN Forma ft ON( pl.root_id=ft.ID )
         );
ALTER TABLE VerbArg ADD INDEX (root_id), ADD INDEX(trueTarget);


DROP TABLE IF EXISTS ArgsCatOrder;
CREATE TABLE ArgsCatOrder (
  `root_id` int(10) unsigned,
   argsOrder CHAR(255),
   argsOrder_Sb CHAR(30),
   argsOrder_Obj CHAR(30),
   argsOrder_OComp CHAR(30),
   argsOrder_Pnom CHAR(30),
   PRIMARY KEY (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ArgsCatOrder(root_id)
SELECT root_id 
FROM ArgsCat; 

-- general order
-- call verbsArgsOverlap( NULL );

UPDATE ArgsCatOrder a,
(
SELECT root_id, 
       group_concat( IF( v.rank < mx AND v.rank > mn, CONCAT(lab, '+'), lab ) 
       ORDER BY mn SEPARATOR ';') AS l,
       group_concat( IF(lab = 'Sb' OR lab = 'V', IF( v.rank < mx AND v.rank > mn, CONCAT(lab, '+'), lab ) 
                                  , NULL) ORDER BY mn SEPARATOR ';') AS lSb,
       group_concat( IF(lab = 'Obj' OR lab = 'V', IF( v.rank < mx AND v.rank > mn, CONCAT(lab, '+'), lab ) 
                                   , NULL) ORDER BY mn SEPARATOR ';') AS lObj,
       group_concat( IF(lab = 'Pnom' OR lab = 'V', IF( v.rank < mx AND v.rank > mn, CONCAT(lab, '+'), lab ) 
                                    , NULL) ORDER BY mn SEPARATOR ';') AS lPnom,
       group_concat( IF(lab = 'OComp' OR lab = 'V', IF( v.rank < mx AND v.rank > mn, CONCAT(lab, '+'), lab ) 
                                     , NULL) ORDER BY mn SEPARATOR ';') AS lOComp
FROM VerbArg, Forma v
WHERE v.ID = VerbArg.root_id
GROUP BY root_id
) t
SET a.argsOrder = TRIM(TRAILING ';' FROM IF( INSTR(t.l, '+')>0, REPLACE( REPLACE( REPLACE(t.l,'V',''), ';;', ';'), '+', '+V'), t.l) ),
 a.argsOrder_Sb = TRIM(TRAILING ';' FROM 
 NULLIF(IF( INSTR(t.lSb, '+')>0, REPLACE( REPLACE( REPLACE(t.lSb,'V',''), ';;', ';'), '+', '+V'), t.lSb),'V') ),
 a.argsOrder_Obj = TRIM(TRAILING ';' FROM 
 NULLIF(IF( INSTR(t.lObj, '+')>0, REPLACE( REPLACE( REPLACE(t.lObj,'V',''), ';;', ';'), '+', '+V'), t.lObj),'V') ),
 a.argsOrder_Pnom = TRIM(TRAILING ';' FROM
 NULLIF(IF( INSTR(t.lPnom, '+')>0, REPLACE( REPLACE( REPLACE(t.lPnom,'V',''), ';;', ';'), '+', '+V'), t.lPnom),'V') ),
 a.argsOrder_OComp = TRIM(TRAILING ';' FROM
 NULLIF(IF( INSTR(t.lOComp, '+')>0, REPLACE( REPLACE( REPLACE(t.lOComp,'V',''), ';;', ';'), '+', '+V'), t.lOComp),'V') )
WHERE a.root_id=t.root_id;


