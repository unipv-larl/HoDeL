
CREATE OR REPLACE VIEW lessico_valenza AS

SELECT f.lemma, f.ID, t.scf1, t.scc1, t.scf2, t.scc2, t.scc3, t.scc4, f.frase
FROM TreeView t,Forma f where t.root_id=f.ID
order by lemma;


CREATE OR REPLACE VIEW lessico_valenza_conusintr AS

SELECT f.lemma, t.diatesi,f.ID, t.scf1, t.scc1, t.scf2, t.scc2, t.scc3, t.scc4, f.frase
FROM TreeView_conusintr t,Forma f where t.root_id=f.ID
order by lemma;

CREATE OR REPLACE VIEW lessico_valenza_conusintr_condiat AS

SELECT f.lemma, f.ID,
CONCAT( t.diatesi, '_', t.scf1 ) as scf1_diat,
CONCAT( t.diatesi, '_', t.scc1 ) as scc1_diat,
CONCAT( t.diatesi, '_', t.scf2 ) as scf2_diat,
CONCAT( t.diatesi, '_', t.scc2 ) as scc2_diat,
CONCAT( t.diatesi, '_', t.scc3 ) as scc3_diat,
CONCAT( t.diatesi, '_', t.scc4 ) as scc4_diat,
f.frase
FROM TreeView_conusintr t,Forma f where t.root_id=f.ID
order by lemma;

