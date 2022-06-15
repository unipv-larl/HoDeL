
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
call verbsArgsOverlap( NULL );

UPDATE ArgsCatOrder a,
(
SELECT root_id, group_concat(lab_All ORDER BY mn SEPARATOR ';') AS l
FROM VerbArg 
GROUP BY root_id
) t
SET a.argsOrder=t.l
WHERE a.root_id=t.root_id;

-- V,Sb Order
call verbsArgsOverlap( 'Sb' );

UPDATE ArgsCatOrder a,
(
SELECT root_id, group_concat(lab_Sb ORDER BY mn SEPARATOR ';') AS l 
FROM VerbArg 
GROUP BY root_id
) t
SET a.argsOrder_Sb=IF( INSTR(t.l, 'V')>0 AND INSTR(t.l, 'Sb')>0, t.l, NULL)
WHERE a.root_id=t.root_id;


-- V,Obj Order
call verbsArgsOverlap( 'Obj' );

UPDATE ArgsCatOrder a,
(
SELECT root_id, group_concat(lab_Obj ORDER BY mn SEPARATOR ';') AS l 
FROM VerbArg 
GROUP BY root_id
) t
SET a.argsOrder_Obj=IF( INSTR(t.l, 'V')>0 AND INSTR(t.l, 'Obj')>0, t.l, NULL)
WHERE a.root_id=t.root_id;


-- V,Pnom Order
call verbsArgsOverlap( 'Pnom' );

UPDATE ArgsCatOrder a,
(
SELECT root_id, group_concat(lab_Pnom ORDER BY mn SEPARATOR ';') AS l 
FROM VerbArg 
GROUP BY root_id
) t
SET a.argsOrder_Pnom=IF( INSTR(t.l, 'V')>0 AND INSTR(t.l, 'Pnom')>0, t.l, NULL)
WHERE a.root_id=t.root_id;


-- V,OComp Order
call verbsArgsOverlap( 'OComp' );

UPDATE ArgsCatOrder a,
(
SELECT root_id, group_concat(lab_OComp ORDER BY mn SEPARATOR ';') AS l 
FROM VerbArg 
GROUP BY root_id
) t
SET a.argsOrder_OComp=IF( INSTR(t.l, 'V')>0 AND INSTR(t.l, 'OComp')>0, t.l, NULL)
WHERE a.root_id=t.root_id;


