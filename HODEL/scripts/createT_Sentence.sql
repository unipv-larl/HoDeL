
DROP TABLE IF EXISTS Sentence;

CREATE TABLE Sentence (
   `id` int(10) unsigned NOT NULL auto_increment,
   `code` char(100) NOT NULL,
   PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO Sentence(code)
   SELECT distinct frase 
   FROM Forma;

-- modifica campo 'frase': foreign key verso la tabella sentence

ALTER TABLE Forma
    ADD COLUMN tempFrase int(10) unsigned NOT NULL default '0';

UPDATE Forma f INNER JOIN Sentence s ON (f.frase=s.code)
    SET f.tempFrase=s.id; 

ALTER TABLE Forma
    DROP INDEX frase;

ALTER TABLE Forma
    DROP COLUMN frase;

ALTER TABLE Forma
    CHANGE COLUMN tempFrase frase int(10) unsigned NOT NULL default '0';

ALTER TABLE Forma
    ADD UNIQUE ( `frase`, `rank` );

ALTER TABLE Forma
    ADD FOREIGN KEY (frase) REFERENCES Sentence(id) ON DELETE CASCADE  ON UPDATE CASCADE;

