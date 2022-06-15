
-- AGGIUNTA CAMPI PER AGDT

DROP TABLE IF EXISTS Sentence;

CREATE TABLE Sentence (
   `id` int(10) unsigned NOT NULL auto_increment,
-- NOTA : identificativo temporaneo della frase costituito da subdoc#document_id   
--   `code` char(100) NOT NULL,
   `code` char(255) NOT NULL,
--
  `subdoc` char(31) NOT NULL,
  `id_AGDT` int(10) unsigned NOT NULL, -- perseus sentence id
  `document_id` char(224) NOT NULL, -- perseus document id
--   
   PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO Sentence(code,subdoc,id_AGDT,document_id)
   SELECT distinct frase,subdoc,id_AGDT,document_id 
   FROM Forma
-- nota fisso ordine testuale document_id, id_AGDT   
   ORDER BY document_id, id_AGDT;

-- 
ALTER TABLE Forma
    DROP COLUMN subdoc,
    DROP COLUMN id_AGDT,
    DROP COLUMN document_id;


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

-- elimino campo code di Sentence:
ALTER TABLE Sentence
    DROP COLUMN code;
