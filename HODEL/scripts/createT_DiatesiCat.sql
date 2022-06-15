
DROP TABLE IF EXISTS DiatesiCat;

CREATE TABLE DiatesiCat (
  `root_id` int(10) unsigned,
   diatesi CHAR(1),
   PRIMARY KEY (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO DiatesiCat(root_id, diatesi)
   SELECT ID, diatesi(modo, lemma)
   FROM Forma
   WHERE pos='2' OR pos='3';

