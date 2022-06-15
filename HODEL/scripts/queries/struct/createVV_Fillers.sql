CREATE OR REPLACE VIEW Formanuova AS

SELECT ID, forma,
-- CAST(lemma AS CHAR(256) ) AS lemma,
lemma,
IF (pos="3",'Vb',if(pos="2",'Pt',pos)) as pos,
grado_nom, cat_fl,
CAST(TRIM( TRAILING '_Ap' FROM  TRIM(TRAILING '_Co' FROM afun ) ) AS CHAR(256)) as afunsenzacoap,
IF (modo="A" or modo="J", "indic",
  IF(modo="B" or modo="K", "cong",
  IF (modo="C" or modo="L", "imper",
  IF(modo="D" or modo="M", "part",
  IF(modo="E" or modo="N", "gerundio",
  IF(modo="O", "gerundivo",
  IF(modo="G" or modo="P", "supino",
  IF(modo="H" or modo="Q", "inf", "-")))))))) as modo,
IF (modo IN('A', 'B', 'C', 'D', 'E', 'G', 'H'), "A", if (modo in ('J','K','L','M','N','O','P','Q') ,if( lemma like '%r',"D", "P"),NULL) ) as diatesi,
IF (modo IN('A', 'B', 'C', 'D', 'E', 'G', 'H'), "A", if (modo in ('J','K','L','M','N','O','P','Q') ,if( lemma like '%r',"A", "P"),NULL) ) as diatesi_nondep,
tempo, grado_part,
IF (caso IN ('A','J'),"nom", IF(caso IN ('B','K'),"gen", IF(caso IN ('C','L'), "dat",IF (caso IN ('D','M'), "acc",IF(caso IN ('E','N'),"voc",IF(caso IN ('F','O'),"abl", IF (caso="G","adv","-"))))))) AS caso,
IF (pos<>"3",IF (caso IN ('A','J'),"nom", IF(caso IN ('B','K'),"gen", IF(caso IN ('C','L'), "dat",IF (caso IN ('D','M'), "acc",IF(caso IN ('E','N'),"voc",IF(caso IN ('F','O'),"abl", IF (caso="G","adv","-"))))))),IF (modo="A" or modo="J", "indic",IF(modo="B" or modo="K", "cong",IF (modo="C" or modo="L", "imper", IF(modo="D" or modo="M", "part", IF(modo="E" or modo="N", "gerundio", IF(modo="O", "gerundivo", IF(modo="G" or modo="P", "supino", IF(modo="H" or modo="Q", "inf", "-"))))))))) AS caso_modo,
gen_num, comp, variaz, variaz_graf,
-- CAST(afun AS CHAR(256) ) AS afun,
afun,
rank, gov, frase
FROM Forma;

-- ma usare il costrutto 'case .. when .. '

CREATE OR REPLACE VIEW myViewForma AS
SELECT ID, pos,forma,lemma,afun,afunsenzacoap,rank,modo,caso,caso_modo,diatesi,diatesi_nondep,
Concat_WS('#','',Concat_WS('#§',Formanuova.caso,Concat_WS('§',Formanuova.lemma,''))) as caso_lemma,
Concat_WS('#','',Concat_WS('#§',Formanuova.caso_modo,Concat_WS('§',Formanuova.lemma,''))) as caso_modo_lemma,
Concat_WS('*','',Concat_WS('*#',Formanuova.afun,concat_WS('#',Formanuova.caso,''))) As afun_caso,
Concat_WS('*','',Concat_WS('*#',Formanuova.afun,concat_WS('#',Formanuova.caso_modo,''))) As afun_caso_modo,
Concat_WS('*','',Concat_WS('*#',Formanuova.afunsenzacoap,concat_WS('#',Formanuova.caso_modo,''))) As afun_caso_modo_senzacoap,
Concat_WS('*','',Concat_WS('*#',Formanuova.afun,Concat_WS('#§',Formanuova.caso,concat_WS('§°',Formanuova.lemma)))) As info_forma_nomodo,
Concat_WS('*','',Concat_WS('*#',Formanuova.afun,Concat_WS('#§',Formanuova.caso_modo,concat_WS('§°',Formanuova.lemma)))) As info_forma,
Concat_WS('*','',Concat_WS('*#',Formanuova.afunsenzacoap,Concat_WS('#§',Formanuova.caso_modo,concat_WS('§°',Formanuova.lemma)))) As info_forma_senzacoap,
frase
FROM Formanuova;


CREATE OR REPLACE VIEW fillers_scc1 AS
SELECT fr.lemma AS verbo, fr.diatesi, tr.scc1,
concat_ws('_',fr.diatesi, tr.scc1) AS scc1_diat, F.*
FROM Tfillers_scc1 F, myViewForma fr, TreeView tr
WHERE F.root_id=fr.ID AND F.root_id=tr.root_id;

CREATE OR REPLACE VIEW fillers_scc2 AS
SELECT fr.lemma AS verbo, fr.diatesi, tr.scc2,
concat_ws('_',fr.diatesi, tr.scc2) AS scc2_diat, F.*
FROM Tfillers_scc2 F, myViewForma fr, TreeView tr
WHERE F.root_id=fr.ID AND F.root_id=tr.root_id;

CREATE OR REPLACE VIEW fillers_scc3 AS
SELECT fr.lemma AS verbo, fr.diatesi, tr.scc3,
concat_ws('_',fr.diatesi, tr.scc3) AS scc3_diat, F.*
FROM Tfillers_scc3 F, myViewForma fr, TreeView tr
WHERE F.root_id=fr.ID AND F.root_id=tr.root_id;


CREATE OR REPLACE VIEW fillers_scc4 AS
SELECT fr.lemma AS verbo, fr.diatesi, tr.scc4,
concat_ws('_',fr.diatesi_nondep, tr.scc4) AS scc4_diat_nondep,
concat_ws('_',fr.diatesi_nondep, tr.scc4) AS scc4_diat,
concat_ws('_',fr.diatesi, _afun_caso_modo_scc4_diat) AS afun_caso_modo_scc4_diat, 
concat_ws('_',fr.diatesi, _completo_fillers_scc4) AS completo_Tfillers_scc4, 
F.*
FROM Tfillers_scc4 F, myViewForma fr, TreeView tr
WHERE F.root_id=fr.ID AND F.root_id=tr.root_id;


CREATE OR REPLACE VIEW fillers_scf1 AS
SELECT fr.lemma AS verbo, fr.diatesi, tr.scf1,
concat_ws('_',fr.diatesi, tr.scf1) AS scf1_diat, F.*
FROM Tfillers_scf1 F, myViewForma fr, TreeView tr
WHERE F.root_id=fr.ID AND F.root_id=tr.root_id;

CREATE OR REPLACE VIEW fillers_scf2 AS
SELECT fr.lemma AS verbo, fr.diatesi, tr.scf2,
concat_ws('_',fr.diatesi, tr.scf2) AS scf2_diat, F.*
FROM Tfillers_scf2 F, myViewForma fr, TreeView tr
WHERE F.root_id=fr.ID AND F.root_id=tr.root_id;

