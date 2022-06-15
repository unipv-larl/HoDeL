-- etichetta alberi: (percorso)Foglia...V...
-- DROP TABLE IF EXISTS TreeView;
-- CREATE TABLE TreeView 
UPDATE TreeView, 
(
SELECT pl.root_id,
     CAST( 
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel) > 0 , 
                            CONCAT( '(', pl.pathLabel, ')', ft.afun ), 
                            IF(ft.ID<>fr.ID, ft.afun, 'V' ) ) 
                            ORDER BY ft.rank 
                            SEPARATOR '+'
               ) 
     AS CHAR(256) ) AS scf1,
     CAST( 
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel) > 0 , 
                            CONCAT( '(', pl.pathLabel, ')', ft.afun ), 
                            IF(ft.ID<>fr.ID, ft.afun, NULL ) ) 
                            ORDER BY ft.afun 
               ) 
     AS CHAR(256) ) AS scc1

FROM
(   (SELECT s.root_id, s.target_id,
           CAST( 
                GROUP_CONCAT( IF( alias, CONCAT( fp.afun, '[', alias, ']' ), fp.afun ) ORDER BY depth ) 
           AS CHAR(256) ) AS pathLabel
    FROM Summa s LEFT JOIN Forma fp
    ON s.parent_id=fp.ID AND depth > 1
    GROUP BY s.root_id, s.target_id )
    UNION 
    (SELECT DISTINCT s.root_id, s.root_id, '' FROM Summa s)
) pl, Forma ft, Forma fr 
WHERE pl.target_id=ft.ID AND pl.root_id=fr.ID
GROUP BY pl.root_id
) AS tv
SET TreeView.scf1 = tv.scf1, TreeView.scc1 = tv.scc1
WHERE TreeView.root_id= tv.root_id;


