
DROP TABLE IF EXISTS ArgsCat;

CREATE TABLE ArgsCat (
  `root_id` int(10) unsigned,
   argsSet CHAR(255),
   argsCard int(5),
   PRIMARY KEY (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ArgsCat(root_id, argsSet, argsCard)
   SELECT r.root_id, CAST( GROUP_CONCAT( r.lab ORDER BY r.lab) AS CHAR(256) ), COUNT(*)
   FROM ( 
         SELECT DISTINCT pl.root_id, IF(tc.target_id IS NULL, pl.target_id, tc.coord_id) AS trueTarget, 
                            TRIM( TRAILING '_Ap' FROM  TRIM(TRAILING '_Co' FROM ft.afun ) ) AS lab  
         FROM
             TargetRoot pl 
             LEFT JOIN TargetCoord tc ON (tc.target_id=pl.target_id), Forma ft
             WHERE pl.target_id=ft.ID 
         ) r
   GROUP BY r.root_id;

