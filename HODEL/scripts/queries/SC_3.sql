UPDATE TreeView, 
(
   SELECT r.root_id, CAST( GROUP_CONCAT( r.lab ORDER BY r.lab) AS CHAR(256) )AS scc3
   FROM ( 
         SELECT DISTINCT pl.root_id, IF(tc.target_id IS NULL, pl.target_id, tc.coord_id) AS trueTarget, 
                            TRIM( TRAILING '_Ap' FROM  TRIM(TRAILING '_Co' FROM ft.afun ) ) AS lab  
         FROM
             TargetRoot pl 
             LEFT JOIN TargetCoord tc ON (tc.target_id=pl.target_id), Forma ft
             WHERE pl.target_id=ft.ID 
         ) r
   GROUP BY r.root_id
) tv
SET TreeView.scc3 = tv.scc3
WHERE TreeView.root_id= tv.root_id;

