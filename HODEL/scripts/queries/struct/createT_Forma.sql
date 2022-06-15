DROP TABLE IF EXISTS `Forma`;

CREATE TABLE `Forma` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `forma` char(30) NOT NULL,
  `lemma` char(30) NOT NULL,
-- PAOLO
-- perseus postag
/*  
  `pos` char(1) NOT NULL,
  `grado_nom` char(1) NOT NULL,
  `cat_fl` char(1) NOT NULL,
  `modo` char(1) NOT NULL,
  `tempo` char(1) NOT NULL,
  `grado_part` char(1) NOT NULL,
  `caso` char(1) NOT NULL,
  `gen_num` char(1) NOT NULL,
  `comp` char(1) NOT NULL,
  `variaz` char(1) NOT NULL,
  `variaz_graf` char(1) NOT NULL,
*/
  `pos` char(1) NOT NULL,
  `pers` char(1) NOT NULL,
  `num` char(1) NOT NULL,
  `tense` char(1) NOT NULL,
  `mood` char(1) NOT NULL,
  `voice` char(1) NOT NULL,
  `gend` char(1) NOT NULL,
  `case` char(1) NOT NULL,
  `degree` char(1) NOT NULL,
--OLOAP  
  `afun` char(10) NOT NULL,
  `rank` int(10) unsigned NOT NULL,
  `gov` int(10) unsigned NOT NULL,
  `frase` char(100) NOT NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE ( `frase`, `rank` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

