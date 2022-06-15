
INSERT INTO Tfillers_scf2

SELECT  pl.root_id, 
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF( coordAlias, CONCAT( ft.lemma, '[', coordAlias, ']' ), ft.lemma ), NULL )
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS fillers_scf2,
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF( coordAlias, CONCAT( ft.lemma, '[', coordAlias, ']' ), ft.lemma ), 'V' )
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS fillers_verbo_scf2,
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF( coordAlias, CONCAT( ft.caso, '[', coordAlias, ']' ), ft.caso ), NULL )
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS caso_scf2,
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF( coordAlias, CONCAT( ft.caso_modo, '[', coordAlias, ']' ), ft.caso_modo ), NULL )
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS caso_modo_scf2,
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF( coordAlias, CONCAT( ft.afun_caso, '[', coordAlias, ']' ), ft.afun_caso ), NULL)
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS afun_caso_scf2,
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF( coordAlias, CONCAT( ft.afun_caso_modo, '[', coordAlias, ']' ), ft.afun_caso_modo ), NULL)
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS afun_caso_modo_scf2,
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF(coordAlias, CONCAT( ft.caso_lemma, '[', coordAlias, ']' ), ft.caso_lemma), NULL)
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS caso_fillers_scf2,
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF(coordAlias, CONCAT( ft.caso_modo_lemma, '[', coordAlias, ']' ), ft.caso_modo_lemma), NULL)
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS caso_modo_fillers_scf2,
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF(coordAlias, CONCAT('[',fr.diatesi,']_',CONCAT( ft.info_forma_nomodo, '[', coordAlias, ']' )), CONCAT('[',fr.diatesi,']_',ft.info_forma_nomodo)), NULL)
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS completo_nomodo_fillers_scf2,
   CAST(
              GROUP_CONCAT( IF(ft.ID<>fr.ID,
                            IF(coordAlias, CONCAT('[',fr.diatesi,']_',CONCAT( ft.info_forma, '[', coordAlias, ']' )), CONCAT('[',fr.diatesi,']_',ft.info_forma)), NULL)
                            ORDER BY ft.rank
                            SEPARATOR '+'
               )
   AS CHAR(256) ) AS completo_fillers_scf2
FROM
(   (SELECT tr.root_id, tr.target_id, md AS coordAlias
    FROM TargetRoot tr LEFT JOIN TargetCoord tc ON tr.target_id=tc.target_id )
    UNION
    (SELECT DISTINCT s.root_id, s.root_id, '' FROM Summa s)
-- ) pl, myViewForma ft, myViewForma fr, treeview tr
-- WHERE pl.target_id=ft.ID AND pl.root_id=fr.ID and tr.root_id=pl.root_id
) pl, myViewForma ft, myViewForma fr
WHERE pl.target_id=ft.ID AND pl.root_id=fr.ID
GROUP BY pl.root_id
-- Order by verbo;
