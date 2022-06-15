-- congiunzioni degli argomenti
-- nb: vincolo di unicità
CREATE TEMPORARY TABLE `ArgConj` (
  `root_id` int(11) unsigned NOT NULL,
  `arg_id` int(11) unsigned NOT NULL,
  `conj` char(20),
  PRIMARY KEY (`root_id`, `arg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ArgConj
SELECT p.root_id, p.target_id as arg_id, f.lemma as conj
FROM Path p, Forma f 
WHERE p.parent_id = f.ID AND f.afun = 'AuxC';

ALTER TABLE VerbArgument
ADD COLUMN `conj` char(20);

UPDATE VerbArgument va,
(
SELECT *
FROM ArgConj
) t
SET va.conj = t.conj
WHERE va.arg_id = t.arg_id AND va.root_id = t.root_id;

