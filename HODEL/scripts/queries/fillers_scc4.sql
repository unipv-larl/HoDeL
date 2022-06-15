
INSERT INTO Tfillers_scc4

SELECT pl.root_id,
-- fr.lemma AS verbo,fr.diatesi,
-- tr.scc4,

   CAST( -- concat_ws('_',fr.diatesi,
        GROUP_CONCAT( distinct IF( LENGTH(pl.pathLabel1_auxp) > 0,
                            CONCAT( '(', pl.pathLabel1_auxp, ')', ft.afun_caso_modo_senzacoap  ),
                            ft.afun_caso_modo_senzacoap   )
                            ORDER BY ft.afun)
             --  )
--   AS CHAR(256) ) AS afun_caso_modo_scc4_diat,
   AS CHAR(256) ) AS _afun_caso_modo_scc4_diat,
   CAST(  -- concat_ws('_',fr.diatesi,
   GROUP_CONCAT( distinct IF( LENGTH(pl.pathLabel1_auxp) > 0,
                            CONCAT( '(', pl.pathLabel1_auxp, ')',  ft.info_forma_senzacoap ),
                            ft.info_forma_senzacoap  )
                            ORDER BY ft.afun)
             --  )
--   AS CHAR(256) ) AS completo_fillers_scc4,
   AS CHAR(256) ) AS _completo_fillers_scc4,
   GROUP_CONCAT(  ft.lemma order by ft.lemma)  AS lista_fillers_scc4,
   GROUP_CONCAT(  concat((if(ft.pos='Vb','V',
  if(ft.modo='part',concat('Pt*', ft.lemma),if(ft.modo='gerundio',concat('Go*',ft.lemma),if(ft.modo='gerundivo',concat('Givo*',ft.lemma),ft.lemma)))
  )),'-',ft.afunsenzacoap) order by ft.lemma) AS lista_fillersafunptgg_novb_scc4,
   GROUP_CONCAT( concat((if(ft.pos='Vb','V', ft.lemma)),'-',ft.afunsenzacoap) order by ft.lemma) AS lista_fillersafun_novb_scc4,
   GROUP_CONCAT( IF(ft.pos='Vb','V', ft.lemma) order by ft.lemma) AS lista_fillers_novb_scc4,
   GROUP_CONCAT( IF(ft.pos='Vb','V', if(ft.pos='Pt','Pt', ft.lemma)) order by ft.lemma)AS lista_fillers_novbpt_scc4
FROM
(   (SELECT s.root_id, s.target_id,
           CAST(
                GROUP_CONCAT( if (fp.afun='AuxP', fp.lemma, NULL)  ORDER BY depth )
           AS CHAR(256) ) AS pathLabel1_auxp
    FROM Summa s LEFT JOIN myViewForma fp
    ON s.parent_id=fp.ID AND depth > 1
    GROUP BY s.root_id, s.target_id )
-- ) pl,myViewForma ft, myViewForma fr, treeview tr
-- WHERE pl.target_id=ft.ID AND pl.root_id=fr.ID and tr.root_id=pl.root_id
) pl,myViewForma ft
WHERE pl.target_id=ft.ID
GROUP BY pl.root_id;


