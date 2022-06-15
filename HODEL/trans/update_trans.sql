
UPDATE Forma 
        INNER JOIN forme_lemmi ON Forma.forma COLLATE utf8_bin = forme_lemmi.str_greek
SET forma_trans = str_trans;

UPDATE Forma 
        INNER JOIN forme_lemmi ON Forma.lemma = forme_lemmi.str_greek
SET lemma_trans = str_trans, lemma_r_trans = REVERSE(str_trans);

UPDATE VerbArgument 
        INNER JOIN forme_lemmi ON VerbArgument.lemma = forme_lemmi.str_greek
SET lemma_trans = str_trans, lemma_r_trans = REVERSE(str_trans);

