-- NB: ORDER BY ft.afun?????

INSERT INTO Tfillers_scc3

SELECT pl1.root_id, 
      CAST(
            GROUP_CONCAT( DISTINCT IF(ft.ID<>fr.ID,
                          ft.lemma,  CONCAT( 'V[', ft.lemma, ']' ))
--                          ORDER BY ft.afun
                          ORDER BY pl1.target_afun
             )
      AS CHAR(256) ) AS fillers_verbo_scc3,
      CAST(
            GROUP_CONCAT( DISTINCT IF(ft.ID<>fr.ID,
                          ft.lemma,  NULL )
--                          ORDER BY ft.afun
                          ORDER BY pl1.target_afun
             )
   AS CHAR(256) ) AS fillers_scc3,
      CAST(
            GROUP_CONCAT( DISTINCT IF(ft.ID<>fr.ID,
                          ft.caso,  NULL )
--                          ORDER BY ft.afun
                          ORDER BY pl1.target_afun
             )
   AS CHAR(256) ) AS caso_scc3,
      CAST(
            GROUP_CONCAT( DISTINCT IF(ft.ID<>fr.ID,
                          ft.caso_modo,  NULL )
 --                          ORDER BY ft.afun
                          ORDER BY pl1.target_afun
             )
   AS CHAR(256) ) AS caso_modo_scc3,
      CAST(
            GROUP_CONCAT( DISTINCT IF(ft.ID<>fr.ID,
--                          pl1.target_afun_caso_modo_senzacoap,NULL)
--                          ORDER BY pl1.target_afun_caso_modo_senzacoap
                          ft.afun_caso_modo_senzacoap,NULL)
                          ORDER BY ft.afun_caso_modo_senzacoap
             )
   AS CHAR(256) ) AS afun_caso_modo_scc3,
      CAST(
            GROUP_CONCAT( DISTINCT IF(ft.ID<>fr.ID,
                          ft.caso_lemma,  NULL )
--                          ORDER BY ft.afun
                          ORDER BY pl1.target_afun
             )
   AS CHAR(256) ) AS caso_fillers_scc3,
      CAST(
            GROUP_CONCAT( DISTINCT IF(ft.ID<>fr.ID,
                          ft.caso_modo_lemma,  NULL )
--                          ORDER BY ft.afun
                          ORDER BY pl1.target_afun
             )
   AS CHAR(256) ) AS caso_modo_fillers_scc3,
         CAST(
            GROUP_CONCAT( DISTINCT IF(ft.ID<>fr.ID,
--                          CONCAT('[',fr.diatesi,']_',pl1.target_info_forma_senzacoap),NULL)
--                          ORDER BY pl1.target_afun_caso_modo_senzacoap
                          CONCAT('[',fr.diatesi,']_',ft.info_forma_senzacoap),NULL)
                          ORDER BY ft.afun_caso_modo_senzacoap
             )
   AS CHAR(256) ) AS completo_fillers_scc3
FROM
-- (   (SELECT tr.root_id, tr.id, md AS coordAlias
--    FROM TargetRoot tr LEFT JOIN TargetCoord tc ON tr.target_id=tc.target_id )
--    UNION
--    (SELECT DISTINCT s.root_id, s.root_id, '' FROM Summa s)
-- ) pl,
(
    -- nodi non coordinati 
    (SELECT tr.root_id, tr.target_id, tr.target_afun
    FROM (SELECT TargetRoot.*, afun AS target_afun FROM TargetRoot, Forma WHERE target_id=ID) tr 
          LEFT JOIN TargetCoord tc ON tr.target_id=tc.target_id 
    WHERE tc.target_id IS NULL)  

    UNION ALL
    -- nodi coordinati
    (SELECT tr.root_id, tr.target_id, tr.target_afun
    FROM (SELECT TargetRoot.*, TRIM( TRAILING '_Ap' FROM TRIM(TRAILING '_Co' FROM afun ) ) AS target_afun 
          FROM TargetRoot, Forma WHERE target_id=ID) tr 
          JOIN TargetCoord tc ON tr.target_id=tc.target_id 
    GROUP BY  tr.root_id, tr.target_afun, tc.coord_id )
) pl1,
-- myViewForma ft, myViewForma fr, treeview tr
-- WHERE pl.target_id=ft.ID AND pl.root_id=fr.ID and tr.root_id=pl.root_id and pl1.root_id=fr.ID
myViewForma ft, myViewForma fr
-- WHERE pl.target_id=ft.ID AND pl.root_id=fr.ID and pl1.root_id=fr.ID
-- GROUP BY pl.root_id

WHERE pl1.target_id=ft.ID AND pl1.root_id=fr.ID
GROUP BY pl1.root_id

-- Order by verbo;

