
-- etichetta alberi: (percorso)Foglia...V...

-- ALTER IGNORE TABLE TreeView ADD scf2 CHAR(255),
-- ADD scc2 CHAR(255);

UPDATE TreeView, 
( 
SELECT pl.root_id,
     CAST( 
              GROUP_CONCAT( IF(ft.ID<>fr.ID, 
                            IF( coordAlias, CONCAT( ft.afun, '[', coordAlias, ']' ), ft.afun ), 
                            'V' )  
                            ORDER BY ft.rank 
                            SEPARATOR '+'
               ) 
     AS CHAR(256) ) AS scf2,
     CAST( 
              GROUP_CONCAT( IF(ft.ID<>fr.ID, 
                            IF( coordAlias, CONCAT( ft.afun, '[', coordAlias, ']' ), ft.afun ), 
                            NULL )  
                            ORDER BY ft.afun, coordAlias
               ) 
     AS CHAR(256) ) AS scc2

FROM
(   (SELECT tr.root_id, tr.target_id, md AS coordAlias
    FROM TargetRoot tr LEFT JOIN TargetCoord tc ON tr.target_id=tc.target_id )
    UNION 
    (SELECT DISTINCT s.root_id, s.root_id, '' FROM Summa s)
) pl, Forma ft, Forma fr 
WHERE pl.target_id=ft.ID AND pl.root_id=fr.ID
GROUP BY pl.root_id 
) AS tv
SET TreeView.scf2 = tv.scf2, TreeView.scc2 = tv.scc2
WHERE TreeView.root_id= tv.root_id;

