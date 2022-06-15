CREATE OR REPLACE VIEW TreeView_conusintr AS
-- SELECT t.root_id, f.lemma AS verbo,f.diatesi,scf1,scc1,t.scc4,scc4_diat_nondep,scc4_diat,scf2, scc2,scc3
-- FROM TreeView t, myViewForma f, fillers_scc4 
-- WHERE t.root_id=f.ID AND t.root_id=fillers_scc4.root_id
-- UNION ALL
SELECT f.ID AS root_id, f.lemma AS verbo, f.diatesi, 'V' as scf1, 'V' as scc1,
'--' as scc4 ,
concat_ws('_',f.diatesi_nondep,'V') as scc4_diat_nondep, 
concat_ws('_',f.diatesi,'V') as scc4_diat,
'V' as scf2, 'V' as scc2, 'V' as scc3 
FROM myViewForma f
LEFT JOIN TreeView t ON ID=root_id
WHERE root_id IS NULL
AND (pos='Vb' OR pos='Pt');
