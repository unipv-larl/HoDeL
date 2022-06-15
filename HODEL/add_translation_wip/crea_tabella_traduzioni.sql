-- crea tabella traduzioni

CREATE TABLE IF NOT EXISTS Sentence_Translation ( 
    sentence_id int(10) unsigned NOT NULL,
    sentence_text text,
    PRIMARY KEY (sentence_id),
    CONSTRAINT FOREIGN KEY (`sentence_id`) REFERENCES `Sentence` (`id`) ON DELETE CASCADE ON UPDATE CASCADE     
);
