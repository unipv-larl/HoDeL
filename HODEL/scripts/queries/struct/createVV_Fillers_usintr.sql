#fillers scf1 con usi intransitivi

CREATE OR REPLACE VIEW fillers_scf1_conusintr AS
-- (
-- SELECT root_id, verbo,
-- fillers_scf1.diatesi, scf1, scf1_diat,
-- fillers_auxpc_coordapos_scf1, fillers_verbo_scf1, fillers_scf1,
-- caso_scf1, caso_modo_scf1, afun_caso_scf1, afun_caso_modo_scf1,
-- caso_fillers_scf1, caso_modo_fillers_scf1,
-- completo_nomodo_fillers_scf1, completo_fillers_scf1
-- FROM fillers_scf1
-- )
-- UNION ALL
-- (
SELECT f.ID AS root_id, f.lemma as verbo,
f.diatesi as diatesi,
'V' as scf1, 
concat_ws('_',f.diatesi,'V') as scf1_diat,
'V' as fillers_auxpc_coordapos_scf1,
concat('V[',f.lemma,']') as fillers_verbo_scf1,
'--' as fillers_scf1,
'--' AS caso_scf1,'--' AS caso_modo_scf1,
'V' AS afun_caso_scf1,
'V' AS afun_caso_modo_scf1,
'--' AS caso_fillers_scf1, 
'--' AS caso_modo_fillers_scf1,
CONCAT('[',f.diatesi,']') AS completo_nomodo_fillers_scf1, 
CONCAT('[',f.diatesi,']') as completo_fillers_scf1
FROM myViewForma f
LEFT JOIN fillers_scf1 ON ID=root_id
WHERE root_id IS NULL
AND (pos='Vb' OR pos='Pt');
-- );



#fillers scc1 con usi intransitivi

CREATE OR REPLACE VIEW  fillers_scc1_conusintr AS
-- (SELECT root_id, verbo,
-- fillers_scc1.diatesi, scc1, scc1_diat,
-- fillers_auxpc_coordapos_scc1, fillers_verbo_scc1, fillers_scc1,
-- caso_scc1, caso_modo_scc1, afun_caso_scc1, afun_caso_modo_scc1,
-- caso_fillers_scc1, caso_modo_fillers_scc1,
-- completo_nomodo_fillers_scc1, completo_fillers_scc1
-- FROM fillers_scc1
-- )
-- UNION ALL
-- (
SELECT f.ID AS root_id, f.lemma as verbo,
f.diatesi as diatesi,
'V' as scc1, 
concat_ws('_',f.diatesi,'V') as scc1_diat,
'V' as fillers_auxpc_coordapos_scc1,
concat('V[',f.lemma,']') as fillers_verbo_scc1,
 '--' as fillers_scc1,
'--' AS caso_scc1,
'--' AS caso_modo_scc1,
'V' AS afun_caso_scc1,
'V' AS afun_caso_modo_scc1,
'--' AS caso_fillers_scc1, 
'--' AS caso_modo_fillers_scc1,
CONCAT('[',f.diatesi,']') AS completo_nomodo_fillers_scc1, 
CONCAT('[',f.diatesi,']') as completo_fillers_scc1
FROM myViewForma f
LEFT JOIN fillers_scc1 ON ID=root_id
WHERE root_id IS NULL
AND (pos='Vb' OR pos='Pt');
-- );



#fillers scf2 con usi intransitivi

CREATE OR REPLACE VIEW fillers_scf2_conusintr AS
-- (
-- SELECT root_id, verbo,
-- fillers_scf2.diatesi, scf2, scf2_diat, fillers_verbo_scf2, fillers_scf2,
-- caso_scf2, caso_modo_scf2, afun_caso_scf2, afun_caso_modo_scf2,
-- caso_fillers_scf2, caso_modo_fillers_scf2,
-- completo_nomodo_fillers_scf2, completo_fillers_scf2
-- FROM fillers_scf2
-- )
-- UNION ALL 
-- (
SELECT f.ID AS root_id, f.lemma as verbo,
f.diatesi as diatesi,
'V' as scf2, 
concat_ws('_',f.diatesi,'V') as scf2_diat,
concat('V[',f.lemma,']') as fillers_verbo_scf2,
 '--' as fillers_scf2,
'--' AS caso_scf2,
'--' AS caso_modo_scf2,
'V' AS afun_caso_scf2,
'V' AS afun_caso_modo_scf2,
'--' AS caso_fillers_scf2, 
'--' AS caso_modo_fillers_scf2,
CONCAT('[',f.diatesi,']') AS completo_nomodo_fillers_scf2, 
CONCAT('[',f.diatesi,']') as completo_fillers_scf2
FROM myViewForma f
LEFT JOIN fillers_scf2 ON ID=root_id
WHERE root_id IS NULL
AND (pos='Vb' OR pos='Pt');
-- );


#fillers scc2 con usi intransitivi

CREATE OR REPLACE VIEW fillers_scc2_conusintr AS
-- (
-- SELECT root_id, verbo,
-- fillers_scc2.diatesi, scc2, scc2_diat, fillers_verbo_scc2, fillers_scc2,
-- caso_scc2, caso_modo_scc2, afun_caso_scc2, afun_caso_modo_scc2,
-- caso_fillers_scc2, caso_modo_fillers_scc2,
-- completo_nomodo_fillers_scc2, completo_fillers_scc2
-- FROM fillers_scc2
-- )
-- UNION ALL
-- (
SELECT f.ID AS root_id, f.lemma as verbo,
f.diatesi as diatesi,'V' as scc2, 
concat_ws('_',f.diatesi,'V') as scc2_diat,
concat('V[',f.lemma,']') as fillers_verbo_scc2,
 '--' as fillers_scc2,
'--' AS caso_scc2,
'--' AS caso_modo_scc2,
'V' AS afun_caso_scc2,
'V' AS afun_caso_modo_scc2,
'--' AS caso_fillers_scc2, 
'--' AS caso_modo_fillers_scc2,
CONCAT('[',f.diatesi,']') AS completo_nomodo_fillers_scc2, 
CONCAT('[',f.diatesi,']') as completo_fillers_scc2
FROM myViewForma f
LEFT JOIN fillers_scc2 ON ID=root_id
WHERE root_id IS NULL
AND (pos='Vb' OR pos='Pt');
-- );



#fillers scc3 con usi intransitivi

CREATE OR REPLACE VIEW  fillers_scc3_conusintr AS
-- (
-- SELECT root_id, verbo,
-- fillers_scc3.diatesi, scc3, scc3_diat, fillers_verbo_scc3, fillers_scc3,
-- caso_scc3, caso_modo_scc3, afun_caso_modo_scc3,
-- caso_fillers_scc3, caso_modo_fillers_scc3,
-- completo_fillers_scc3
-- FROM fillers_scc3
-- )
-- UNION ALL
-- (
SELECT f.ID AS root_id, f.lemma as verbo,
f.diatesi as diatesi,
'V' as scc3, 
concat_ws('_',f.diatesi,'V') as scc3_diat,
concat('V[',f.lemma,']') as fillers_verbo_scc3,
 '--' as fillers_scc3,
'--' AS caso_scc3,
'--' AS caso_modo_scc3,
'V' AS afun_caso_modo_scc3,
'--' AS caso_fillers_scc3, 
'--' AS caso_modo_fillers_scc3, 
CONCAT('[',f.diatesi,']') as completo_fillers_scc3
FROM myViewForma f
LEFT JOIN fillers_scc3 ON ID=root_id
WHERE root_id IS NULL
AND (pos='Vb' OR pos='Pt');
-- );


