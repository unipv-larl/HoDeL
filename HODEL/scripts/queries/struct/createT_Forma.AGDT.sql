DROP TABLE IF EXISTS `Forma`;

CREATE TABLE `Forma` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `forma` char(30) NOT NULL,
  `lemma` char(30) NOT NULL COLLATE utf8_bin,  -- NOTA BENE
  `posAGDT` char(1) NOT NULL,
  `pers` char(1) NOT NULL,
  `num` char(1) NOT NULL,
  `tense` char(1) NOT NULL,
  `mood` char(1) NOT NULL,
  `voice` char(1) NOT NULL,
  `gend` char(1) NOT NULL,
  `case` char(1) NOT NULL,
  `degree` char(1) NOT NULL,
  `afun` char(10) NOT NULL,
  `rank` int(10) unsigned NOT NULL,
  `gov` int(10) unsigned NOT NULL,
  `frase` char(255) NOT NULL,
  `cite` char(255) NULL,
  `subdoc` char(31) NOT NULL,
  `id_AGDT` int(10) unsigned NOT NULL, -- perseus sentence id
  `document_id` char(224) NOT NULL, -- perseus document id
  PRIMARY KEY  (`ID`),
  UNIQUE ( `frase`, `rank` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

