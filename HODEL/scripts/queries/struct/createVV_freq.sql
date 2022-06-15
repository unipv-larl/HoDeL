-- per contare la frequenza di scf1 con il verbo

CREATE OR REPLACE VIEW freq_verbo_scf1 AS

SELECT verbo ,scf1_diat, count(scf1_diat) as freq_verbo_scf1_diat FROM fillers_scf1
group by verbo,scf1_diat
order by verbo,freq_verbo_scf1_diat DESC;

CREATE OR REPLACE VIEW freq_verbo_scf1_conusintr AS

SELECT verbo ,scf1_diat, count(scf1_diat) as freq_verbo_scf1_diat FROM fillers_scf1_conusintr
group by verbo,scf1_diat
order by verbo,freq_verbo_scf1_diat DESC;

-- per contare la frequenza di scc1 con il verbo

CREATE OR REPLACE VIEW freq_verbo_scc1 AS

SELECT verbo ,scc1_diat, count(scc1_diat) as freq_verbo_scc1_diat FROM fillers_scc1
group by verbo,scc1_diat
order by verbo,freq_verbo_scc1_diat DESC;

CREATE OR REPLACE VIEW freq_verbo_scc1_conusintr AS

SELECT verbo ,scc1_diat, count(scc1_diat) as freq_verbo_scc1_diat FROM fillers_scc1_conusintr
group by verbo,scc1_diat
order by verbo,freq_verbo_scc1_diat DESC;

-- per contare la frequenza di scf2 con il verbo

CREATE OR REPLACE VIEW freq_verbo_scf2 AS

SELECT verbo ,scf2_diat, count(scf2_diat) as freq_verbo_scf2_diat FROM fillers_scf2
group by verbo,scf2_diat
order by verbo,freq_verbo_scf2_diat DESC;

CREATE OR REPLACE VIEW freq_verbo_scf2_conusintr AS

SELECT verbo ,scf2_diat, count(scf2_diat) as freq_verbo_scf2_diat FROM fillers_scf2_conusintr
group by verbo,scf2_diat
order by verbo,freq_verbo_scf2_diat DESC;

-- per contare la frequenza di scc2 con il verbo

CREATE OR REPLACE VIEW freq_verbo_scc2 AS

SELECT verbo ,scc2_diat, count(scc2_diat) as freq_verbo_scc2_diat FROM fillers_scc2
group by verbo,scc2_diat
order by verbo,freq_verbo_scc2_diat DESC;

CREATE OR REPLACE VIEW freq_verbo_scc2_conusintr AS

SELECT verbo ,scc2_diat, count(scc2_diat) as freq_verbo_scc2_diat FROM fillers_scc2_conusintr
group by verbo,scc2_diat
order by verbo,freq_verbo_scc2_diat DESC;

-- per contare la frequenza di scc3 con il verbo

CREATE OR REPLACE VIEW freq_verbo_scc3 AS

SELECT verbo ,scc3_diat, count(scc3_diat) as freq_verbo_scc3_diat FROM fillers_scc3
group by verbo,scc3_diat
order by verbo,freq_verbo_scc3_diat DESC;

CREATE OR REPLACE VIEW freq_verbo_scc3_afuncasomodo AS

SELECT verbo ,diatesi, afun_caso_modo_scc3, count(afun_caso_modo_scc3) as freq_verbo_scc3_afun_caso_modo
FROM fillers_scc3
group by verbo,afun_caso_modo_scc3
order by verbo,afun_caso_modo_scc3 DESC;

CREATE OR REPLACE VIEW freq_verbo_scc3_conusintr AS

SELECT verbo ,scc3_diat, count(scc3_diat) as freq_verbo_scc3_diat
FROM fillers_scc3_conusintr
group by verbo,scc3_diat
order by verbo,freq_verbo_scc3_diat DESC;

CREATE OR REPLACE VIEW freq_verbo_scc3_afuncasomodo_conusintr AS

SELECT verbo ,diatesi, afun_caso_modo_scc3, count(afun_caso_modo_scc3) as freq_verbo_scc3_afun_caso_modo
FROM fillers_scc3_conusintr
group by verbo,afun_caso_modo_scc3
order by verbo,afun_caso_modo_scc3 DESC;


-- per contare la frequenza del verbo
CREATE OR REPLACE VIEW frequenze_verbo AS
SELECT f.lemma as verbo, count(*) as freq_verbo
-- FROM valenza.lessico_valenza_conusintr_condiat l,myViewForma f where l.ID=f.ID
FROM lessico_valenza_conusintr_condiat l,myViewForma f where l.ID=f.ID
group by verbo
order by freq_verbo desc;


-- per contare la frequenza di scf1
CREATE OR REPLACE VIEW freq_scf1 AS
SELECT scf1_diat, count(*) as freq_scf1_diat FROM fillers_scf1
group by scf1_diat
order by scf1_diat;

-- per contare la frequenza di scc1
CREATE OR REPLACE VIEW freq_scc1 AS
SELECT scc1_diat, count(*) as freq_scc1_diat FROM fillers_scc1
group by scc1_diat
order by scc1_diat;

-- per contare la frequenza di scf2
CREATE OR REPLACE VIEW freq_scf2 AS
SELECT scf2_diat, count(*) as freq_scf2_diat FROM fillers_scf2
group by scf2_diat
order by scf2_diat;

-- per contare la frequenza di scc2
CREATE OR REPLACE VIEW freq_scc2 AS
SELECT scc2_diat, count(*) as freq_scc2_diat FROM fillers_scc2
group by scc2_diat
order by scc2_diat;

-- per contare la frequenza di scc3
CREATE OR REPLACE VIEW freq_scc3 AS
SELECT scc3_diat, count(*) as freq_scc3_diat FROM fillers_scc3
group by scc3_diat
order by scc3_diat;

