-- preposizioni degli argomenti
-- nb: vincolo di unicità
CREATE TEMPORARY TABLE `ArgPrep` (
  `root_id` int(11) unsigned NOT NULL,
  `arg_id` int(11) unsigned NOT NULL,
  `prep` char(20),
  PRIMARY KEY (`root_id`, `arg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ArgPrep
SELECT p.root_id, p.target_id as arg_id, f.lemma as prep
FROM Path p, Forma f 
WHERE p.parent_id = f.ID AND f.afun = 'AuxP';

ALTER TABLE VerbArgument
ADD COLUMN `prep` char(20);

UPDATE VerbArgument va,
(
SELECT *
FROM ArgPrep
) t
SET va.prep = t.prep
WHERE va.arg_id = t.arg_id AND va.root_id = t.root_id;
