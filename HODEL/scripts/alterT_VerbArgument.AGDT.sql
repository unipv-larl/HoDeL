
-- CREA CAMPI Indicizzazione e ricerca dei lemmi

-- il campo principale 'lemma' è case/accent sensitive:
-- `lemma` char(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL (vedi definizione)
-- uso questo campo per ricerca

-- creo campo copia in versione case insensitive (default collation della tabella utf8)
-- creo campo lemma_r_ci 
ALTER TABLE `VerbArgument`
    ADD COLUMN `lemma_r_ci` char(30) NOT NULL AFTER `lemma`,
    ADD COLUMN `lemma_ci` char(30) NOT NULL AFTER `lemma`;

UPDATE `VerbArgument` 
    SET lemma_ci = lemma, lemma_r_ci = REVERSE(lemma); 


-- INDICIZZO i campi 'lemma'
ALTER TABLE `VerbArgument` 
    ADD INDEX (`lemma`),
    ADD INDEX (`lemma_ci`),
    ADD INDEX (`lemma_r_ci`);

    
