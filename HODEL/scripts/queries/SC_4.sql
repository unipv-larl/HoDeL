-- etichetta alberi: (percorso)Foglia...V...
UPDATE TreeView, 
(
  SELECT r.root_id, CAST( GROUP_CONCAT( r.lab ORDER BY r.lab) AS CHAR(256) )AS scc4
  FROM ( 
         SELECT DISTINCT pl.root_id, IF(tc.target_id IS NULL, pl.target_id, tc.coord_id) AS trueTarget, 
                            IF( LENGTH(pl.pathLabel1_auxp) > 0,
                            CONCAT( '(', pl.pathLabel1_auxp, ')', TRIM( TRAILING '_Ap' FROM  TRIM(TRAILING '_Co' FROM ft.afun ) ) ),
                            TRIM( TRAILING '_Ap' FROM  TRIM(TRAILING '_Co' FROM ft.afun ) )  )  AS lab  

         FROM
             ( SELECT s.root_id, s.target_id, 
                             CAST( GROUP_CONCAT( if (fp.afun='AuxP', fp.lemma, NULL)  ORDER BY depth )
                             AS CHAR(256) ) AS pathLabel1_auxp
               FROM Summa s LEFT JOIN Forma fp ON s.parent_id=fp.ID AND depth > 1
               GROUP BY s.root_id, s.target_id 
             ) pl 
             LEFT JOIN TargetCoord tc ON (tc.target_id=pl.target_id), Forma ft
             WHERE pl.target_id=ft.ID 
         ) r
   GROUP BY r.root_id
) tv
SET TreeView.scc4 = tv.scc4
WHERE TreeView.root_id= tv.root_id;

