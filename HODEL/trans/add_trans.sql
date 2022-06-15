-- add translitterations field


-- ALTER TABLE Forma ADD INDEX (forma);



-- ALTER TABLE Forma 
--        ADD COLUMN forma_trans char(30) NOT NULL AFTER forma,
--        ADD COLUMN lemma_r_trans char(30) NOT NULL AFTER lemma,
--        ADD COLUMN lemma_trans char(30) NOT NULL AFTER lemma;

-- UPDATE Forma 
        -- INNER JOIN forme_lemmi ON Forma.forma COLLATE utf8_bin = forme_lemmi.str_greek
-- SET forma_trans = str_trans;

-- UPDATE Forma 
        -- INNER JOIN forme_lemmi ON Forma.lemma = forme_lemmi.str_greek
-- SET lemma_trans = str_trans, lemma_r_trans = REVERSE(str_trans);

-- ************ TEMP ***************
ALTER TABLE Forma 
       ADD COLUMN lemma_r_trans char(30) NOT NULL AFTER lemma_trans;
UPDATE Forma 
        INNER JOIN forme_lemmi ON Forma.lemma = forme_lemmi.str_greek
SET lemma_r_trans = REVERSE(str_trans);
-- ************ TEMP ***************

ALTER TABLE `Forma` 
    ADD INDEX (`lemma_trans`),
    ADD INDEX (`lemma_r_trans`);



ALTER TABLE VerbArgument 
       ADD COLUMN lemma_r_trans char(30) NOT NULL AFTER lemma,
       ADD COLUMN lemma_trans char(30) NOT NULL AFTER lemma;


UPDATE VerbArgument 
        INNER JOIN forme_lemmi ON VerbArgument.lemma = forme_lemmi.str_greek
SET lemma_trans = str_trans, lemma_r_trans = REVERSE(str_trans);

ALTER TABLE `VerbArgument` 
    ADD INDEX (`lemma_trans`),
    ADD INDEX (`lemma_r_trans`);
