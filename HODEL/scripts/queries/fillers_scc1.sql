
INSERT INTO Tfillers_scc1

SELECT pl.root_id,
   CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT( '(', pl.pathLabel1, ')', ft.afun ),
                            IF(ft.ID<>fr.ID, ft.afun, NULL )  )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS fillers_auxpc_coordapos_scc1,
     CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT( '(', pl.pathLabel1, ')', ft.lemma ),
                            IF(ft.ID<>fr.ID, ft.lemma, CONCAT( 'V[', ft.lemma, ']' ) ) )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS fillers_verbo_scc1,
     CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT( '(', pl.pathLabel1, ')', ft.lemma ),
                            IF(ft.ID<>fr.ID, ft.lemma, NULL )  )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS fillers_scc1,
   CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT( '(', pl.pathLabel1, ')', ft.caso ),
                            IF(ft.ID<>fr.ID, ft.caso, NULL ) )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS caso_scc1,
   CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT( '(', pl.pathLabel1, ')', ft.caso_modo ),
                            IF(ft.ID<>fr.ID, ft.caso_modo, NULL ) )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS caso_modo_scc1,
   CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT( '(', pl.pathLabel1, ')', ft.afun_caso ),
                            IF(ft.ID<>fr.ID, ft.afun_caso, NULL) )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS afun_caso_scc1,
   CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT( '(', pl.pathLabel1, ')', ft.afun_caso_modo ),
                            IF(ft.ID<>fr.ID, ft.afun_caso_modo, NULL) )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS afun_caso_modo_scc1,
   CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT( '(', pl.pathLabel1, ')', ft.caso_lemma ),
                            IF(ft.ID<>fr.ID, ft.caso_lemma, NULL) )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS caso_fillers_scc1,
   CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT( '(', pl.pathLabel1, ')', ft.caso_modo_lemma ),
                            IF(ft.ID<>fr.ID, ft.caso_modo_lemma, NULL) )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS caso_modo_fillers_scc1,
   CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT('[',fr.diatesi,']_',CONCAT( '(', pl.pathLabel1, ')', ft.info_forma_nomodo )),
                            IF(ft.ID<>fr.ID, CONCAT('[',fr.diatesi,']_',ft.info_forma_nomodo), NULL ) )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS completo_nomodo_fillers_scc1,
   CAST(
              GROUP_CONCAT( IF( LENGTH(pl.pathLabel1) > 0 ,
                            CONCAT('[',fr.diatesi,']_',CONCAT( '(', pl.pathLabel1, ')', ft.info_forma )),
                            IF(ft.ID<>fr.ID, CONCAT('[',fr.diatesi,']_',ft.info_forma), NULL ) )
                            ORDER BY ft.afun
               )
   AS CHAR(256) ) AS completo_fillers_scc1
FROM
(   (SELECT s.root_id, s.target_id,
--           CAST(
--                GROUP_CONCAT( IF( alias, CONCAT( fp.afun, '[', alias, ']' ), fp.afun ) ORDER BY depth )
--           AS CHAR(256) ) AS pathLabel,
           CAST(
                GROUP_CONCAT( fp.lemma  ORDER BY depth )
           AS CHAR(256) ) AS pathLabel1
    FROM Summa s LEFT JOIN myViewForma fp
    ON s.parent_id=fp.ID AND depth > 1
    GROUP BY s.root_id, s.target_id )
    UNION
--    (SELECT DISTINCT s.root_id, s.root_id, '', '' FROM Summa s)
    (SELECT DISTINCT s.root_id, s.root_id, '' FROM Summa s)

-- ) pl,myViewForma ft, myViewForma fr, treeview tr
-- WHERE pl.target_id=ft.ID AND pl.root_id=fr.ID and tr.root_id=pl.root_id
) pl,myViewForma ft, myViewForma fr
WHERE pl.target_id=ft.ID AND pl.root_id=fr.ID
GROUP BY pl.root_id;
-- Order by verbo;

