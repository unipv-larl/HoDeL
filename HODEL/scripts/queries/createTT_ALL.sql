-- MySQL dump 10.11
--
-- Host: localhost    Database: master
-- ------------------------------------------------------
-- Server version	5.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `Diatesi`
--

DROP TABLE IF EXISTS `Diatesi`;
/*!50001 DROP VIEW IF EXISTS `Diatesi`*/;
/*!50001 CREATE TABLE `Diatesi` (
  `ID` int(10) unsigned,
  `diatesi` varchar(1),
  `diatesi_nondep` varchar(1)
) */;

--
-- Table structure for table `Forma`
--

DROP TABLE IF EXISTS `Forma`;
CREATE TABLE `Forma` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `forma` char(30) NOT NULL,
  `lemma` char(30) NOT NULL,
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
  `afun` char(10) NOT NULL,
  `rank` int(10) unsigned NOT NULL,
  `gov` int(10) unsigned NOT NULL,
  `frase` char(100) NOT NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `frase` (`frase`,`rank`)
) ENGINE=InnoDB AUTO_INCREMENT=3985314 DEFAULT CHARSET=utf8;

--
-- Temporary table structure for view `Formanuova`
--

DROP TABLE IF EXISTS `Formanuova`;
/*!50001 DROP VIEW IF EXISTS `Formanuova`*/;
/*!50001 CREATE TABLE `Formanuova` (
  `ID` int(10) unsigned,
  `forma` char(30),
  `lemma` char(30),
  `pos` varchar(2),
  `grado_nom` char(1),
  `cat_fl` char(1),
  `afunsenzacoap` varchar(256),
  `modo` varchar(9),
  `diatesi` varchar(1),
  `diatesi_nondep` varchar(1),
  `tempo` char(1),
  `grado_part` char(1),
  `caso` varchar(3),
  `caso_modo` varchar(9),
  `gen_num` char(1),
  `comp` char(1),
  `variaz` char(1),
  `variaz_graf` char(1),
  `afun` char(10),
  `rank` int(10) unsigned,
  `gov` int(10) unsigned,
  `frase` char(100)
) */;

--
-- Temporary table structure for view `InPath1`
--

DROP TABLE IF EXISTS `InPath1`;
/*!50001 DROP VIEW IF EXISTS `InPath1`*/;
/*!50001 CREATE TABLE `InPath1` (
  `ID` int(10) unsigned,
  `forma` char(30),
  `lemma` char(30),
  `pos` char(1),
  `grado_nom` char(1),
  `cat_fl` char(1),
  `modo` char(1),
  `tempo` char(1),
  `grado_part` char(1),
  `caso` char(1),
  `gen_num` char(1),
  `comp` char(1),
  `variaz` char(1),
  `variaz_graf` char(1),
  `afun` char(10),
  `rank` int(10) unsigned,
  `gov` int(10) unsigned,
  `frase` char(100)
) */;

--
-- Temporary table structure for view `InPath2`
--

DROP TABLE IF EXISTS `InPath2`;
/*!50001 DROP VIEW IF EXISTS `InPath2`*/;
/*!50001 CREATE TABLE `InPath2` (
  `ID` int(10) unsigned,
  `forma` char(30),
  `lemma` char(30),
  `pos` char(1),
  `grado_nom` char(1),
  `cat_fl` char(1),
  `modo` char(1),
  `tempo` char(1),
  `grado_part` char(1),
  `caso` char(1),
  `gen_num` char(1),
  `comp` char(1),
  `variaz` char(1),
  `variaz_graf` char(1),
  `afun` char(10),
  `rank` int(10) unsigned,
  `gov` int(10) unsigned,
  `frase` char(100)
) */;

--
-- Table structure for table `Path`
--

DROP TABLE IF EXISTS `Path`;
CREATE TABLE `Path` (
  `target_id` int(10) unsigned NOT NULL default '0',
  `parent_id` int(10) unsigned default '0',
  `depth` int(10) unsigned NOT NULL default '0',
  KEY `target_id` (`target_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `Path_ibfk_1` FOREIGN KEY (`target_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Path_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Temporary table structure for view `RootCoord`
--

DROP TABLE IF EXISTS `RootCoord`;
/*!50001 DROP VIEW IF EXISTS `RootCoord`*/;
/*!50001 CREATE TABLE `RootCoord` (
  `root_id` int(10) unsigned,
  `coord_id` int(10) unsigned
) */;

--
-- Table structure for table `RootCoordIndex`
--

DROP TABLE IF EXISTS `RootCoordIndex`;
CREATE TABLE `RootCoordIndex` (
  `root_id` int(10) unsigned NOT NULL default '0',
  `coord_id` int(10) unsigned default '0',
  `alias` int(10) unsigned NOT NULL default '0',
  KEY `root_id` (`root_id`),
  KEY `coord_id` (`coord_id`),
  CONSTRAINT `RootCoordIndex_ibfk_1` FOREIGN KEY (`root_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RootCoordIndex_ibfk_2` FOREIGN KEY (`coord_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `Summa`
--

DROP TABLE IF EXISTS `Summa`;
CREATE TABLE `Summa` (
  `root_id` int(10) unsigned NOT NULL default '0',
  `target_id` int(10) unsigned NOT NULL default '0',
  `parent_id` int(10) unsigned default '0',
  `depth` int(10) unsigned NOT NULL default '0',
  `alias` int(10) unsigned NOT NULL default '0',
  KEY `root_id` (`root_id`),
  KEY `target_id` (`target_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `Summa_ibfk_1` FOREIGN KEY (`root_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Summa_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Summa_ibfk_3` FOREIGN KEY (`parent_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Temporary table structure for view `Target1`
--

DROP TABLE IF EXISTS `Target1`;
/*!50001 DROP VIEW IF EXISTS `Target1`*/;
/*!50001 CREATE TABLE `Target1` (
  `ID` int(10) unsigned,
  `forma` char(30),
  `lemma` char(30),
  `pos` char(1),
  `grado_nom` char(1),
  `cat_fl` char(1),
  `modo` char(1),
  `tempo` char(1),
  `grado_part` char(1),
  `caso` char(1),
  `gen_num` char(1),
  `comp` char(1),
  `variaz` char(1),
  `variaz_graf` char(1),
  `afun` char(10),
  `rank` int(10) unsigned,
  `gov` int(10) unsigned,
  `frase` char(100)
) */;

--
-- Temporary table structure for view `Target2`
--

DROP TABLE IF EXISTS `Target2`;
/*!50001 DROP VIEW IF EXISTS `Target2`*/;
/*!50001 CREATE TABLE `Target2` (
  `ID` int(10) unsigned,
  `forma` char(30),
  `lemma` char(30),
  `pos` char(1),
  `grado_nom` char(1),
  `cat_fl` char(1),
  `modo` char(1),
  `tempo` char(1),
  `grado_part` char(1),
  `caso` char(1),
  `gen_num` char(1),
  `comp` char(1),
  `variaz` char(1),
  `variaz_graf` char(1),
  `afun` char(10),
  `rank` int(10) unsigned,
  `gov` int(10) unsigned,
  `frase` char(100)
) */;

--
-- Table structure for table `TargetCoord`
--

DROP TABLE IF EXISTS `TargetCoord`;
CREATE TABLE `TargetCoord` (
  `target_id` int(10) unsigned NOT NULL default '0',
  `coord_id` int(10) unsigned default '0',
  `md` int(10) unsigned NOT NULL default '0',
  KEY `target_id` (`target_id`),
  KEY `coord_id` (`coord_id`),
  CONSTRAINT `TargetCoord_ibfk_1` FOREIGN KEY (`target_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TargetCoord_ibfk_2` FOREIGN KEY (`coord_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Temporary table structure for view `TargetRoot`
--

DROP TABLE IF EXISTS `TargetRoot`;
/*!50001 DROP VIEW IF EXISTS `TargetRoot`*/;
/*!50001 CREATE TABLE `TargetRoot` (
  `target_id` int(10) unsigned,
  `root_id` int(10) unsigned
) */;

--
-- Table structure for table `Tfillers_scc1`
--

DROP TABLE IF EXISTS `Tfillers_scc1`;
CREATE TABLE `Tfillers_scc1` (
  `root_id` int(11) unsigned NOT NULL default '0',
  `fillers_auxpc_coordapos_scc1` varchar(256) default NULL,
  `fillers_verbo_scc1` varchar(256) default NULL,
  `fillers_scc1` varchar(256) default NULL,
  `caso_scc1` varchar(256) default NULL,
  `caso_modo_scc1` varchar(256) default NULL,
  `afun_caso_scc1` varchar(256) default NULL,
  `afun_caso_modo_scc1` varchar(256) default NULL,
  `caso_fillers_scc1` varchar(256) default NULL,
  `caso_modo_fillers_scc1` varchar(256) default NULL,
  `completo_nomodo_fillers_scc1` varchar(256) default NULL,
  `completo_fillers_scc1` varchar(256) default NULL,
  UNIQUE KEY `root_id` (`root_id`),
  CONSTRAINT `Tfillers_scc1_ibfk_1` FOREIGN KEY (`root_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `Tfillers_scc2`
--

DROP TABLE IF EXISTS `Tfillers_scc2`;
CREATE TABLE `Tfillers_scc2` (
  `root_id` int(11) unsigned default NULL,
  `fillers_verbo_scc2` varchar(256) default NULL,
  `fillers_scc2` varchar(256) default NULL,
  `caso_scc2` varchar(256) default NULL,
  `caso_modo_scc2` varchar(256) default NULL,
  `afun_caso_scc2` varchar(256) default NULL,
  `afun_caso_modo_scc2` varchar(256) default NULL,
  `caso_fillers_scc2` varchar(256) default NULL,
  `caso_modo_fillers_scc2` varchar(256) default NULL,
  `completo_nomodo_fillers_scc2` varchar(256) default NULL,
  `completo_fillers_scc2` varchar(256) default NULL,
  UNIQUE KEY `root_id` (`root_id`),
  CONSTRAINT `Tfillers_scc2_ibfk_1` FOREIGN KEY (`root_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `Tfillers_scc3`
--

DROP TABLE IF EXISTS `Tfillers_scc3`;
CREATE TABLE `Tfillers_scc3` (
  `root_id` int(11) unsigned default NULL,
  `fillers_verbo_scc3` varchar(256) default NULL,
  `fillers_scc3` varchar(256) default NULL,
  `caso_scc3` varchar(256) default NULL,
  `caso_modo_scc3` varchar(256) default NULL,
  `afun_caso_modo_scc3` varchar(256) default NULL,
  `caso_fillers_scc3` varchar(256) default NULL,
  `caso_modo_fillers_scc3` varchar(256) default NULL,
  `completo_fillers_scc3` varchar(256) default NULL,
  UNIQUE KEY `root_id` (`root_id`),
  CONSTRAINT `Tfillers_scc3_ibfk_1` FOREIGN KEY (`root_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `Tfillers_scc4`
--

DROP TABLE IF EXISTS `Tfillers_scc4`;
CREATE TABLE `Tfillers_scc4` (
  `root_id` int(10) unsigned NOT NULL default '0',
  `_afun_caso_modo_scc4_diat` varchar(256) default NULL,
  `_completo_fillers_scc4` varchar(256) default NULL,
  `lista_fillers_scc4` longtext,
  `lista_fillersafunptgg_novb_scc4` longtext,
  `lista_fillersafun_novb_scc4` longtext,
  `lista_fillers_novb_scc4` longtext,
  `lista_fillers_novbpt_scc4` longtext,
  UNIQUE KEY `root_id` (`root_id`),
  CONSTRAINT `Tfillers_scc4_ibfk_1` FOREIGN KEY (`root_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `Tfillers_scf1`
--

DROP TABLE IF EXISTS `Tfillers_scf1`;
CREATE TABLE `Tfillers_scf1` (
  `root_id` int(11) unsigned NOT NULL default '0',
  `fillers_auxpc_coordapos_scf1` varchar(256) default NULL,
  `fillers_verbo_scf1` varchar(256) default NULL,
  `fillers_scf1` varchar(256) default NULL,
  `caso_scf1` varchar(256) default NULL,
  `caso_modo_scf1` varchar(256) default NULL,
  `afun_caso_scf1` varchar(256) default NULL,
  `afun_caso_modo_scf1` varchar(256) default NULL,
  `caso_fillers_scf1` varchar(256) default NULL,
  `caso_modo_fillers_scf1` varchar(256) default NULL,
  `completo_nomodo_fillers_scf1` varchar(256) default NULL,
  `completo_fillers_scf1` varchar(256) default NULL,
  UNIQUE KEY `root_id` (`root_id`),
  CONSTRAINT `Tfillers_scf1_ibfk_1` FOREIGN KEY (`root_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `Tfillers_scf2`
--

DROP TABLE IF EXISTS `Tfillers_scf2`;
CREATE TABLE `Tfillers_scf2` (
  `root_id` int(11) unsigned default NULL,
  `fillers_scf2` varchar(256) default NULL,
  `fillers_verbo_scf2` varchar(256) default NULL,
  `caso_scf2` varchar(256) default NULL,
  `caso_modo_scf2` varchar(256) default NULL,
  `afun_caso_scf2` varchar(256) default NULL,
  `afun_caso_modo_scf2` varchar(256) default NULL,
  `caso_fillers_scf2` varchar(256) default NULL,
  `caso_modo_fillers_scf2` varchar(256) default NULL,
  `completo_nomodo_fillers_scf2` varchar(256) default NULL,
  `completo_fillers_scf2` varchar(256) default NULL,
  UNIQUE KEY `root_id` (`root_id`),
  CONSTRAINT `Tfillers_scf2_ibfk_1` FOREIGN KEY (`root_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `Tree`
--

DROP TABLE IF EXISTS `Tree`;
CREATE TABLE `Tree` (
  `forma_id` int(10) unsigned NOT NULL default '0',
  `parent_id` int(10) unsigned default '0',
  UNIQUE KEY `forma_id` (`forma_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `Tree_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `Forma` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Tree_ibfk_2` FOREIGN KEY (`forma_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `TreeView`
--

DROP TABLE IF EXISTS `TreeView`;
CREATE TABLE `TreeView` (
  `root_id` int(10) unsigned default NULL,
  `scf1` char(255) default NULL,
  `scc1` char(255) default NULL,
  `scf2` char(255) default NULL,
  `scc2` char(255) default NULL,
  `scc3` char(255) default NULL,
  `scc4` char(255) default NULL,
  UNIQUE KEY `root_id` (`root_id`),
  CONSTRAINT `TreeView_ibfk_1` FOREIGN KEY (`root_id`) REFERENCES `Forma` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Temporary table structure for view `TreeView_conusintr`
--

DROP TABLE IF EXISTS `TreeView_conusintr`;
/*!50001 DROP VIEW IF EXISTS `TreeView_conusintr`*/;
/*!50001 CREATE TABLE `TreeView_conusintr` (
  `root_id` int(10) unsigned,
  `verbo` char(30),
  `diatesi` varchar(1),
  `scf1` varchar(1),
  `scc1` varchar(1),
  `scc4` varchar(2),
  `scc4_diat_nondep` varchar(3),
  `scc4_diat` varchar(3),
  `scf2` varchar(1),
  `scc2` varchar(1),
  `scc3` varchar(1)
) */;

--
-- Temporary table structure for view `Verbo`
--

DROP TABLE IF EXISTS `Verbo`;
/*!50001 DROP VIEW IF EXISTS `Verbo`*/;
/*!50001 CREATE TABLE `Verbo` (
  `ID` int(10) unsigned,
  `forma` char(30),
  `lemma` char(30),
  `pos` char(1),
  `grado_nom` char(1),
  `cat_fl` char(1),
  `modo` char(1),
  `tempo` char(1),
  `grado_part` char(1),
  `caso` char(1),
  `gen_num` char(1),
  `comp` char(1),
  `variaz` char(1),
  `variaz_graf` char(1),
  `afun` char(10),
  `rank` int(10) unsigned,
  `gov` int(10) unsigned,
  `frase` char(100)
) */;

--
-- Temporary table structure for view `fillers_scc1`
--

DROP TABLE IF EXISTS `fillers_scc1`;
/*!50001 DROP VIEW IF EXISTS `fillers_scc1`*/;
/*!50001 CREATE TABLE `fillers_scc1` (
  `verbo` char(30),
  `diatesi` varchar(1),
  `scc1` char(255),
  `scc1_diat` varchar(257),
  `root_id` int(11) unsigned,
  `fillers_auxpc_coordapos_scc1` varchar(256),
  `fillers_verbo_scc1` varchar(256),
  `fillers_scc1` varchar(256),
  `caso_scc1` varchar(256),
  `caso_modo_scc1` varchar(256),
  `afun_caso_scc1` varchar(256),
  `afun_caso_modo_scc1` varchar(256),
  `caso_fillers_scc1` varchar(256),
  `caso_modo_fillers_scc1` varchar(256),
  `completo_nomodo_fillers_scc1` varchar(256),
  `completo_fillers_scc1` varchar(256)
) */;

--
-- Temporary table structure for view `fillers_scc1_conusintr`
--

DROP TABLE IF EXISTS `fillers_scc1_conusintr`;
/*!50001 DROP VIEW IF EXISTS `fillers_scc1_conusintr`*/;
/*!50001 CREATE TABLE `fillers_scc1_conusintr` (
  `root_id` int(10) unsigned,
  `verbo` char(30),
  `diatesi` varchar(1),
  `scc1` varchar(1),
  `scc1_diat` varchar(3),
  `fillers_auxpc_coordapos_scc1` varchar(1),
  `fillers_verbo_scc1` varchar(33),
  `fillers_scc1` varchar(2),
  `caso_scc1` varchar(2),
  `caso_modo_scc1` varchar(2),
  `afun_caso_scc1` varchar(1),
  `afun_caso_modo_scc1` varchar(1),
  `caso_fillers_scc1` varchar(2),
  `caso_modo_fillers_scc1` varchar(2),
  `completo_nomodo_fillers_scc1` varchar(3),
  `completo_fillers_scc1` varchar(3)
) */;

--
-- Temporary table structure for view `fillers_scc2`
--

DROP TABLE IF EXISTS `fillers_scc2`;
/*!50001 DROP VIEW IF EXISTS `fillers_scc2`*/;
/*!50001 CREATE TABLE `fillers_scc2` (
  `verbo` char(30),
  `diatesi` varchar(1),
  `scc2` char(255),
  `scc2_diat` varchar(257),
  `root_id` int(11) unsigned,
  `fillers_verbo_scc2` varchar(256),
  `fillers_scc2` varchar(256),
  `caso_scc2` varchar(256),
  `caso_modo_scc2` varchar(256),
  `afun_caso_scc2` varchar(256),
  `afun_caso_modo_scc2` varchar(256),
  `caso_fillers_scc2` varchar(256),
  `caso_modo_fillers_scc2` varchar(256),
  `completo_nomodo_fillers_scc2` varchar(256),
  `completo_fillers_scc2` varchar(256)
) */;

--
-- Temporary table structure for view `fillers_scc2_conusintr`
--

DROP TABLE IF EXISTS `fillers_scc2_conusintr`;
/*!50001 DROP VIEW IF EXISTS `fillers_scc2_conusintr`*/;
/*!50001 CREATE TABLE `fillers_scc2_conusintr` (
  `root_id` int(10) unsigned,
  `verbo` char(30),
  `diatesi` varchar(1),
  `scc2` varchar(1),
  `scc2_diat` varchar(3),
  `fillers_verbo_scc2` varchar(33),
  `fillers_scc2` varchar(2),
  `caso_scc2` varchar(2),
  `caso_modo_scc2` varchar(2),
  `afun_caso_scc2` varchar(1),
  `afun_caso_modo_scc2` varchar(1),
  `caso_fillers_scc2` varchar(2),
  `caso_modo_fillers_scc2` varchar(2),
  `completo_nomodo_fillers_scc2` varchar(3),
  `completo_fillers_scc2` varchar(3)
) */;

--
-- Temporary table structure for view `fillers_scc3`
--

DROP TABLE IF EXISTS `fillers_scc3`;
/*!50001 DROP VIEW IF EXISTS `fillers_scc3`*/;
/*!50001 CREATE TABLE `fillers_scc3` (
  `verbo` char(30),
  `diatesi` varchar(1),
  `scc3` char(255),
  `scc3_diat` varchar(257),
  `root_id` int(11) unsigned,
  `fillers_verbo_scc3` varchar(256),
  `fillers_scc3` varchar(256),
  `caso_scc3` varchar(256),
  `caso_modo_scc3` varchar(256),
  `afun_caso_modo_scc3` varchar(256),
  `caso_fillers_scc3` varchar(256),
  `caso_modo_fillers_scc3` varchar(256),
  `completo_fillers_scc3` varchar(256)
) */;

--
-- Temporary table structure for view `fillers_scc3_conusintr`
--

DROP TABLE IF EXISTS `fillers_scc3_conusintr`;
/*!50001 DROP VIEW IF EXISTS `fillers_scc3_conusintr`*/;
/*!50001 CREATE TABLE `fillers_scc3_conusintr` (
  `root_id` int(10) unsigned,
  `verbo` char(30),
  `diatesi` varchar(1),
  `scc3` varchar(1),
  `scc3_diat` varchar(3),
  `fillers_verbo_scc3` varchar(33),
  `fillers_scc3` varchar(2),
  `caso_scc3` varchar(2),
  `caso_modo_scc3` varchar(2),
  `afun_caso_modo_scc3` varchar(1),
  `caso_fillers_scc3` varchar(2),
  `caso_modo_fillers_scc3` varchar(2),
  `completo_fillers_scc3` varchar(3)
) */;

--
-- Temporary table structure for view `fillers_scc4`
--

DROP TABLE IF EXISTS `fillers_scc4`;
/*!50001 DROP VIEW IF EXISTS `fillers_scc4`*/;
/*!50001 CREATE TABLE `fillers_scc4` (
  `verbo` char(30),
  `diatesi` varchar(1),
  `scc4` char(255),
  `scc4_diat_nondep` varchar(257),
  `scc4_diat` varchar(257),
  `afun_caso_modo_scc4_diat` varchar(258),
  `completo_Tfillers_scc4` varchar(258),
  `root_id` int(10) unsigned,
  `_afun_caso_modo_scc4_diat` varchar(256),
  `_completo_fillers_scc4` varchar(256),
  `lista_fillers_scc4` longtext,
  `lista_fillersafunptgg_novb_scc4` longtext,
  `lista_fillersafun_novb_scc4` longtext,
  `lista_fillers_novb_scc4` longtext,
  `lista_fillers_novbpt_scc4` longtext
) */;

--
-- Temporary table structure for view `fillers_scf1`
--

DROP TABLE IF EXISTS `fillers_scf1`;
/*!50001 DROP VIEW IF EXISTS `fillers_scf1`*/;
/*!50001 CREATE TABLE `fillers_scf1` (
  `verbo` char(30),
  `diatesi` varchar(1),
  `scf1` char(255),
  `scf1_diat` varchar(257),
  `root_id` int(11) unsigned,
  `fillers_auxpc_coordapos_scf1` varchar(256),
  `fillers_verbo_scf1` varchar(256),
  `fillers_scf1` varchar(256),
  `caso_scf1` varchar(256),
  `caso_modo_scf1` varchar(256),
  `afun_caso_scf1` varchar(256),
  `afun_caso_modo_scf1` varchar(256),
  `caso_fillers_scf1` varchar(256),
  `caso_modo_fillers_scf1` varchar(256),
  `completo_nomodo_fillers_scf1` varchar(256),
  `completo_fillers_scf1` varchar(256)
) */;

--
-- Temporary table structure for view `fillers_scf1_conusintr`
--

DROP TABLE IF EXISTS `fillers_scf1_conusintr`;
/*!50001 DROP VIEW IF EXISTS `fillers_scf1_conusintr`*/;
/*!50001 CREATE TABLE `fillers_scf1_conusintr` (
  `root_id` int(10) unsigned,
  `verbo` char(30),
  `diatesi` varchar(1),
  `scf1` varchar(1),
  `scf1_diat` varchar(3),
  `fillers_auxpc_coordapos_scf1` varchar(1),
  `fillers_verbo_scf1` varchar(33),
  `fillers_scf1` varchar(2),
  `caso_scf1` varchar(2),
  `caso_modo_scf1` varchar(2),
  `afun_caso_scf1` varchar(1),
  `afun_caso_modo_scf1` varchar(1),
  `caso_fillers_scf1` varchar(2),
  `caso_modo_fillers_scf1` varchar(2),
  `completo_nomodo_fillers_scf1` varchar(3),
  `completo_fillers_scf1` varchar(3)
) */;

--
-- Temporary table structure for view `fillers_scf2`
--

DROP TABLE IF EXISTS `fillers_scf2`;
/*!50001 DROP VIEW IF EXISTS `fillers_scf2`*/;
/*!50001 CREATE TABLE `fillers_scf2` (
  `verbo` char(30),
  `diatesi` varchar(1),
  `scf2` char(255),
  `scf2_diat` varchar(257),
  `root_id` int(11) unsigned,
  `fillers_scf2` varchar(256),
  `fillers_verbo_scf2` varchar(256),
  `caso_scf2` varchar(256),
  `caso_modo_scf2` varchar(256),
  `afun_caso_scf2` varchar(256),
  `afun_caso_modo_scf2` varchar(256),
  `caso_fillers_scf2` varchar(256),
  `caso_modo_fillers_scf2` varchar(256),
  `completo_nomodo_fillers_scf2` varchar(256),
  `completo_fillers_scf2` varchar(256)
) */;

--
-- Temporary table structure for view `fillers_scf2_conusintr`
--

DROP TABLE IF EXISTS `fillers_scf2_conusintr`;
/*!50001 DROP VIEW IF EXISTS `fillers_scf2_conusintr`*/;
/*!50001 CREATE TABLE `fillers_scf2_conusintr` (
  `root_id` int(10) unsigned,
  `verbo` char(30),
  `diatesi` varchar(1),
  `scf2` varchar(1),
  `scf2_diat` varchar(3),
  `fillers_verbo_scf2` varchar(33),
  `fillers_scf2` varchar(2),
  `caso_scf2` varchar(2),
  `caso_modo_scf2` varchar(2),
  `afun_caso_scf2` varchar(1),
  `afun_caso_modo_scf2` varchar(1),
  `caso_fillers_scf2` varchar(2),
  `caso_modo_fillers_scf2` varchar(2),
  `completo_nomodo_fillers_scf2` varchar(3),
  `completo_fillers_scf2` varchar(3)
) */;

--
-- Temporary table structure for view `freq_scc1`
--

DROP TABLE IF EXISTS `freq_scc1`;
/*!50001 DROP VIEW IF EXISTS `freq_scc1`*/;
/*!50001 CREATE TABLE `freq_scc1` (
  `scc1_diat` varchar(257),
  `freq_scc1_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_scc2`
--

DROP TABLE IF EXISTS `freq_scc2`;
/*!50001 DROP VIEW IF EXISTS `freq_scc2`*/;
/*!50001 CREATE TABLE `freq_scc2` (
  `scc2_diat` varchar(257),
  `freq_scc2_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_scc3`
--

DROP TABLE IF EXISTS `freq_scc3`;
/*!50001 DROP VIEW IF EXISTS `freq_scc3`*/;
/*!50001 CREATE TABLE `freq_scc3` (
  `scc3_diat` varchar(257),
  `freq_scc3_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_scf1`
--

DROP TABLE IF EXISTS `freq_scf1`;
/*!50001 DROP VIEW IF EXISTS `freq_scf1`*/;
/*!50001 CREATE TABLE `freq_scf1` (
  `scf1_diat` varchar(257),
  `freq_scf1_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_scf2`
--

DROP TABLE IF EXISTS `freq_scf2`;
/*!50001 DROP VIEW IF EXISTS `freq_scf2`*/;
/*!50001 CREATE TABLE `freq_scf2` (
  `scf2_diat` varchar(257),
  `freq_scf2_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scc1`
--

DROP TABLE IF EXISTS `freq_verbo_scc1`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc1`*/;
/*!50001 CREATE TABLE `freq_verbo_scc1` (
  `verbo` char(30),
  `scc1_diat` varchar(257),
  `freq_verbo_scc1_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scc1_conusintr`
--

DROP TABLE IF EXISTS `freq_verbo_scc1_conusintr`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc1_conusintr`*/;
/*!50001 CREATE TABLE `freq_verbo_scc1_conusintr` (
  `verbo` char(30),
  `scc1_diat` varchar(3),
  `freq_verbo_scc1_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scc2`
--

DROP TABLE IF EXISTS `freq_verbo_scc2`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc2`*/;
/*!50001 CREATE TABLE `freq_verbo_scc2` (
  `verbo` char(30),
  `scc2_diat` varchar(257),
  `freq_verbo_scc2_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scc2_conusintr`
--

DROP TABLE IF EXISTS `freq_verbo_scc2_conusintr`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc2_conusintr`*/;
/*!50001 CREATE TABLE `freq_verbo_scc2_conusintr` (
  `verbo` char(30),
  `scc2_diat` varchar(3),
  `freq_verbo_scc2_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scc3`
--

DROP TABLE IF EXISTS `freq_verbo_scc3`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc3`*/;
/*!50001 CREATE TABLE `freq_verbo_scc3` (
  `verbo` char(30),
  `scc3_diat` varchar(257),
  `freq_verbo_scc3_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scc3_afuncasomodo`
--

DROP TABLE IF EXISTS `freq_verbo_scc3_afuncasomodo`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc3_afuncasomodo`*/;
/*!50001 CREATE TABLE `freq_verbo_scc3_afuncasomodo` (
  `verbo` char(30),
  `diatesi` varchar(1),
  `afun_caso_modo_scc3` varchar(256),
  `freq_verbo_scc3_afun_caso_modo` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scc3_afuncasomodo_conusintr`
--

DROP TABLE IF EXISTS `freq_verbo_scc3_afuncasomodo_conusintr`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc3_afuncasomodo_conusintr`*/;
/*!50001 CREATE TABLE `freq_verbo_scc3_afuncasomodo_conusintr` (
  `verbo` char(30),
  `diatesi` varchar(1),
  `afun_caso_modo_scc3` varchar(1),
  `freq_verbo_scc3_afun_caso_modo` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scc3_conusintr`
--

DROP TABLE IF EXISTS `freq_verbo_scc3_conusintr`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc3_conusintr`*/;
/*!50001 CREATE TABLE `freq_verbo_scc3_conusintr` (
  `verbo` char(30),
  `scc3_diat` varchar(3),
  `freq_verbo_scc3_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scf1`
--

DROP TABLE IF EXISTS `freq_verbo_scf1`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scf1`*/;
/*!50001 CREATE TABLE `freq_verbo_scf1` (
  `verbo` char(30),
  `scf1_diat` varchar(257),
  `freq_verbo_scf1_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scf1_conusintr`
--

DROP TABLE IF EXISTS `freq_verbo_scf1_conusintr`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scf1_conusintr`*/;
/*!50001 CREATE TABLE `freq_verbo_scf1_conusintr` (
  `verbo` char(30),
  `scf1_diat` varchar(3),
  `freq_verbo_scf1_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scf2`
--

DROP TABLE IF EXISTS `freq_verbo_scf2`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scf2`*/;
/*!50001 CREATE TABLE `freq_verbo_scf2` (
  `verbo` char(30),
  `scf2_diat` varchar(257),
  `freq_verbo_scf2_diat` bigint(21)
) */;

--
-- Temporary table structure for view `freq_verbo_scf2_conusintr`
--

DROP TABLE IF EXISTS `freq_verbo_scf2_conusintr`;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scf2_conusintr`*/;
/*!50001 CREATE TABLE `freq_verbo_scf2_conusintr` (
  `verbo` char(30),
  `scf2_diat` varchar(3),
  `freq_verbo_scf2_diat` bigint(21)
) */;

--
-- Temporary table structure for view `frequenze_verbo`
--

DROP TABLE IF EXISTS `frequenze_verbo`;
/*!50001 DROP VIEW IF EXISTS `frequenze_verbo`*/;
/*!50001 CREATE TABLE `frequenze_verbo` (
  `verbo` char(30),
  `freq_verbo` bigint(21)
) */;

--
-- Temporary table structure for view `lessico_valenza`
--

DROP TABLE IF EXISTS `lessico_valenza`;
/*!50001 DROP VIEW IF EXISTS `lessico_valenza`*/;
/*!50001 CREATE TABLE `lessico_valenza` (
  `lemma` char(30),
  `ID` int(10) unsigned,
  `scf1` char(255),
  `scc1` char(255),
  `scf2` char(255),
  `scc2` char(255),
  `scc3` char(255),
  `scc4` char(255),
  `frase` char(100)
) */;

--
-- Temporary table structure for view `lessico_valenza_conusintr`
--

DROP TABLE IF EXISTS `lessico_valenza_conusintr`;
/*!50001 DROP VIEW IF EXISTS `lessico_valenza_conusintr`*/;
/*!50001 CREATE TABLE `lessico_valenza_conusintr` (
  `lemma` char(30),
  `diatesi` varchar(1),
  `ID` int(10) unsigned,
  `scf1` varchar(1),
  `scc1` varchar(1),
  `scf2` varchar(1),
  `scc2` varchar(1),
  `scc3` varchar(1),
  `scc4` varchar(2),
  `frase` char(100)
) */;

--
-- Temporary table structure for view `lessico_valenza_conusintr_condiat`
--

DROP TABLE IF EXISTS `lessico_valenza_conusintr_condiat`;
/*!50001 DROP VIEW IF EXISTS `lessico_valenza_conusintr_condiat`*/;
/*!50001 CREATE TABLE `lessico_valenza_conusintr_condiat` (
  `lemma` char(30),
  `ID` int(10) unsigned,
  `scf1_diat` varchar(3),
  `scc1_diat` varchar(3),
  `scf2_diat` varchar(3),
  `scc2_diat` varchar(3),
  `scc3_diat` varchar(3),
  `scc4_diat` varchar(4),
  `frase` char(100)
) */;

--
-- Temporary table structure for view `myViewForma`
--

DROP TABLE IF EXISTS `myViewForma`;
/*!50001 DROP VIEW IF EXISTS `myViewForma`*/;
/*!50001 CREATE TABLE `myViewForma` (
  `ID` int(10) unsigned,
  `pos` varchar(2),
  `forma` char(30),
  `lemma` char(30),
  `afun` char(10),
  `afunsenzacoap` varchar(256),
  `rank` int(10) unsigned,
  `modo` varchar(9),
  `caso` varchar(3),
  `caso_modo` varchar(9),
  `diatesi` varchar(1),
  `diatesi_nondep` varchar(1),
  `caso_lemma` varchar(39),
  `caso_modo_lemma` varchar(45),
  `afun_caso` varchar(17),
  `afun_caso_modo` varchar(23),
  `afun_caso_modo_senzacoap` varchar(269),
  `info_forma_nomodo` varchar(49),
  `info_forma` varchar(55),
  `info_forma_senzacoap` varchar(301),
  `frase` char(100)
) */;

--
-- Dumping routines for database 'master'
--
DELIMITER ;;
/*!50003 DROP PROCEDURE IF EXISTS `findPath` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `findPath`(
RootTN VARCHAR(50), TargetTN VARCHAR(50), IntTN VARCHAR(50), PathTN VARCHAR(50)
)
BEGIN
DECLARE nonCompleti INT DEFAULT 0;
CALL initFindPath( RootTN, TargetTN, IntTN );
INSERT INTO _Path
SELECT Tree.forma_id AS target_id, parent_id, 1
FROM Tree INNER JOIN _Target ON Tree.forma_id=_Target.ID; 
REPEAT 
   TRUNCATE _nuoviNodi;
   
   INSERT INTO _nuoviNodi
   SELECT target_id, Tree.parent_id, 1
   FROM _Path, _InPath , Tree
   WHERE depth=1 AND _Path.parent_id = _InPath.ID AND Tree.forma_id=_Path.parent_id;
   
   DELETE FROM _Path 
   USING  _Path LEFT JOIN 
   ( 
     ( SELECT target_id FROM _nuoviNodi )
     UNION  
     ( SELECT target_id FROM _Root, _Path WHERE _Root.ID=_Path.parent_id AND depth=1 )
   ) As P
   ON _Path.target_id=P.target_id
   WHERE P.target_id IS NULL;
   SELECT COUNT(*) INTO nonCompleti FROM _nuoviNodi;
    
   IF nonCompleti > 0 THEN
      
      UPDATE _nuoviNodi INNER JOIN _Path ON (_nuoviNodi.target_id=_Path.target_id)
      SET _Path.depth=_Path.depth+1; 
      INSERT INTO _Path 
      SELECT * FROM _nuoviNodi;
   
   END IF;
UNTIL nonCompleti = 0 END REPEAT;
CALL finFindPath(PathTN);
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `finFindPath` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `finFindPath`(PathTN VARCHAR(50))
BEGIN
SET @Query=CONCAT("DROP TABLE IF EXISTS ", PathTN);
PREPARE stmt FROM @Query;
EXECUTE stmt;
SET @Query=CONCAT("CREATE TABLE ", PathTN, " LIKE _Path");
PREPARE stmt FROM @Query;
EXECUTE stmt;
SET @Query=CONCAT("INSERT INTO ", PathTN, " SELECT * FROM _Path");
PREPARE stmt FROM @Query;
EXECUTE stmt;
DROP TABLE _Path;
DROP TABLE _Root;
DROP TABLE _Target;
DROP TABLE _InPath;
DROP TABLE _nuoviNodi;
DEALLOCATE PREPARE stmt;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `initFindPath` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `initFindPath`(
RootTN VARCHAR(50), TargetTN VARCHAR(50), IntTN VARCHAR(50)
)
BEGIN
CREATE TABLE IF NOT EXISTS _Path (
  target_id int(10) unsigned NOT NULL default '0',
  parent_id int(10) unsigned default '0',
  depth int(10) unsigned NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
TRUNCATE _Path;
CREATE TABLE IF NOT EXISTS _nuoviNodi LIKE _Path;
CREATE TABLE IF NOT EXISTS _Target LIKE Forma;
TRUNCATE _Target;
CREATE TABLE IF NOT EXISTS _Root LIKE Forma;
TRUNCATE _Root;
CREATE TABLE IF NOT EXISTS _InPath LIKE Forma;
TRUNCATE _InPath;
SET @Query=CONCAT("INSERT INTO _Root SELECT * FROM ", RootTN );
PREPARE stmt FROM @Query;
EXECUTE stmt;
SET @Query=CONCAT("INSERT INTO _Target SELECT * FROM ", TargetTN );
PREPARE stmt FROM @Query;
EXECUTE stmt;
SET @Query=CONCAT("INSERT INTO _InPath SELECT * FROM ", IntTN );
PREPARE stmt FROM @Query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
DELIMITER ;

--
-- Final view structure for view `Diatesi`
--

/*!50001 DROP TABLE IF EXISTS `Diatesi`*/;
/*!50001 DROP VIEW IF EXISTS `Diatesi`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Diatesi` AS select `Forma`.`ID` AS `ID`,if((`Forma`.`modo` in (_latin1'A',_latin1'B',_latin1'C',_latin1'D',_latin1'E',_latin1'G',_latin1'H')),_latin1'A',if((`Forma`.`modo` in (_latin1'J',_latin1'K',_latin1'L',_latin1'M',_latin1'N',_latin1'O',_latin1'P',_latin1'Q')),if((`Forma`.`lemma` like _latin1'%r'),_latin1'D',_latin1'P'),NULL)) AS `diatesi`,if((`Forma`.`modo` in (_latin1'A',_latin1'B',_latin1'C',_latin1'D',_latin1'E',_latin1'G',_latin1'H')),_latin1'A',if((`Forma`.`modo` in (_latin1'J',_latin1'K',_latin1'L',_latin1'M',_latin1'N',_latin1'O',_latin1'P',_latin1'Q')),if((`Forma`.`lemma` like _latin1'%r'),_latin1'A',_latin1'P'),NULL)) AS `diatesi_nondep` from `Forma` */;

--
-- Final view structure for view `Formanuova`
--

/*!50001 DROP TABLE IF EXISTS `Formanuova`*/;
/*!50001 DROP VIEW IF EXISTS `Formanuova`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Formanuova` AS select `Forma`.`ID` AS `ID`,`Forma`.`forma` AS `forma`,`Forma`.`lemma` AS `lemma`,if((`Forma`.`pos` = _latin1'3'),_latin1'Vb',if((`Forma`.`pos` = _latin1'2'),_latin1'Pt',`Forma`.`pos`)) AS `pos`,`Forma`.`grado_nom` AS `grado_nom`,`Forma`.`cat_fl` AS `cat_fl`,cast(trim(trailing _latin1'_Ap' from trim(trailing _latin1'_Co' from `Forma`.`afun`)) as char(256) charset latin1) AS `afunsenzacoap`,if(((`Forma`.`modo` = _latin1'A') or (`Forma`.`modo` = _latin1'J')),_latin1'indic',if(((`Forma`.`modo` = _latin1'B') or (`Forma`.`modo` = _latin1'K')),_latin1'cong',if(((`Forma`.`modo` = _latin1'C') or (`Forma`.`modo` = _latin1'L')),_latin1'imper',if(((`Forma`.`modo` = _latin1'D') or (`Forma`.`modo` = _latin1'M')),_latin1'part',if(((`Forma`.`modo` = _latin1'E') or (`Forma`.`modo` = _latin1'N')),_latin1'gerundio',if((`Forma`.`modo` = _latin1'O'),_latin1'gerundivo',if(((`Forma`.`modo` = _latin1'G') or (`Forma`.`modo` = _latin1'P')),_latin1'supino',if(((`Forma`.`modo` = _latin1'H') or (`Forma`.`modo` = _latin1'Q')),_latin1'inf',_latin1'-')))))))) AS `modo`,if((`Forma`.`modo` in (_latin1'A',_latin1'B',_latin1'C',_latin1'D',_latin1'E',_latin1'G',_latin1'H')),_latin1'A',if((`Forma`.`modo` in (_latin1'J',_latin1'K',_latin1'L',_latin1'M',_latin1'N',_latin1'O',_latin1'P',_latin1'Q')),if((`Forma`.`lemma` like _latin1'%r'),_latin1'D',_latin1'P'),NULL)) AS `diatesi`,if((`Forma`.`modo` in (_latin1'A',_latin1'B',_latin1'C',_latin1'D',_latin1'E',_latin1'G',_latin1'H')),_latin1'A',if((`Forma`.`modo` in (_latin1'J',_latin1'K',_latin1'L',_latin1'M',_latin1'N',_latin1'O',_latin1'P',_latin1'Q')),if((`Forma`.`lemma` like _latin1'%r'),_latin1'A',_latin1'P'),NULL)) AS `diatesi_nondep`,`Forma`.`tempo` AS `tempo`,`Forma`.`grado_part` AS `grado_part`,if((`Forma`.`caso` in (_latin1'A',_latin1'J')),_latin1'nom',if((`Forma`.`caso` in (_latin1'B',_latin1'K')),_latin1'gen',if((`Forma`.`caso` in (_latin1'C',_latin1'L')),_latin1'dat',if((`Forma`.`caso` in (_latin1'D',_latin1'M')),_latin1'acc',if((`Forma`.`caso` in (_latin1'E',_latin1'N')),_latin1'voc',if((`Forma`.`caso` in (_latin1'F',_latin1'O')),_latin1'abl',if((`Forma`.`caso` = _latin1'G'),_latin1'adv',_latin1'-'))))))) AS `caso`,if((`Forma`.`pos` <> _latin1'3'),if((`Forma`.`caso` in (_latin1'A',_latin1'J')),_latin1'nom',if((`Forma`.`caso` in (_latin1'B',_latin1'K')),_latin1'gen',if((`Forma`.`caso` in (_latin1'C',_latin1'L')),_latin1'dat',if((`Forma`.`caso` in (_latin1'D',_latin1'M')),_latin1'acc',if((`Forma`.`caso` in (_latin1'E',_latin1'N')),_latin1'voc',if((`Forma`.`caso` in (_latin1'F',_latin1'O')),_latin1'abl',if((`Forma`.`caso` = _latin1'G'),_latin1'adv',_latin1'-'))))))),if(((`Forma`.`modo` = _latin1'A') or (`Forma`.`modo` = _latin1'J')),_latin1'indic',if(((`Forma`.`modo` = _latin1'B') or (`Forma`.`modo` = _latin1'K')),_latin1'cong',if(((`Forma`.`modo` = _latin1'C') or (`Forma`.`modo` = _latin1'L')),_latin1'imper',if(((`Forma`.`modo` = _latin1'D') or (`Forma`.`modo` = _latin1'M')),_latin1'part',if(((`Forma`.`modo` = _latin1'E') or (`Forma`.`modo` = _latin1'N')),_latin1'gerundio',if((`Forma`.`modo` = _latin1'O'),_latin1'gerundivo',if(((`Forma`.`modo` = _latin1'G') or (`Forma`.`modo` = _latin1'P')),_latin1'supino',if(((`Forma`.`modo` = _latin1'H') or (`Forma`.`modo` = _latin1'Q')),_latin1'inf',_latin1'-'))))))))) AS `caso_modo`,`Forma`.`gen_num` AS `gen_num`,`Forma`.`comp` AS `comp`,`Forma`.`variaz` AS `variaz`,`Forma`.`variaz_graf` AS `variaz_graf`,`Forma`.`afun` AS `afun`,`Forma`.`rank` AS `rank`,`Forma`.`gov` AS `gov`,`Forma`.`frase` AS `frase` from `Forma` */;

--
-- Final view structure for view `InPath1`
--

/*!50001 DROP TABLE IF EXISTS `InPath1`*/;
/*!50001 DROP VIEW IF EXISTS `InPath1`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `InPath1` AS select `Forma`.`ID` AS `ID`,`Forma`.`forma` AS `forma`,`Forma`.`lemma` AS `lemma`,`Forma`.`pos` AS `pos`,`Forma`.`grado_nom` AS `grado_nom`,`Forma`.`cat_fl` AS `cat_fl`,`Forma`.`modo` AS `modo`,`Forma`.`tempo` AS `tempo`,`Forma`.`grado_part` AS `grado_part`,`Forma`.`caso` AS `caso`,`Forma`.`gen_num` AS `gen_num`,`Forma`.`comp` AS `comp`,`Forma`.`variaz` AS `variaz`,`Forma`.`variaz_graf` AS `variaz_graf`,`Forma`.`afun` AS `afun`,`Forma`.`rank` AS `rank`,`Forma`.`gov` AS `gov`,`Forma`.`frase` AS `frase` from `Forma` where ((`Forma`.`afun` in (_latin1'AuxC',_latin1'AuxP')) or (`Forma`.`afun` like _latin1'Coord%') or (`Forma`.`afun` like _latin1'Apos%')) */;

--
-- Final view structure for view `InPath2`
--

/*!50001 DROP TABLE IF EXISTS `InPath2`*/;
/*!50001 DROP VIEW IF EXISTS `InPath2`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `InPath2` AS select `Forma`.`ID` AS `ID`,`Forma`.`forma` AS `forma`,`Forma`.`lemma` AS `lemma`,`Forma`.`pos` AS `pos`,`Forma`.`grado_nom` AS `grado_nom`,`Forma`.`cat_fl` AS `cat_fl`,`Forma`.`modo` AS `modo`,`Forma`.`tempo` AS `tempo`,`Forma`.`grado_part` AS `grado_part`,`Forma`.`caso` AS `caso`,`Forma`.`gen_num` AS `gen_num`,`Forma`.`comp` AS `comp`,`Forma`.`variaz` AS `variaz`,`Forma`.`variaz_graf` AS `variaz_graf`,`Forma`.`afun` AS `afun`,`Forma`.`rank` AS `rank`,`Forma`.`gov` AS `gov`,`Forma`.`frase` AS `frase` from `Forma` where (`Forma`.`afun` in (_latin1'AuxC',_latin1'AuxP')) */;

--
-- Final view structure for view `RootCoord`
--

/*!50001 DROP TABLE IF EXISTS `RootCoord`*/;
/*!50001 DROP VIEW IF EXISTS `RootCoord`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `RootCoord` AS select distinct `tr`.`root_id` AS `root_id`,`p`.`parent_id` AS `coord_id` from ((`TargetRoot` `tr` join `Path` `p`) join `Forma` `f`) where ((`p`.`target_id` = `tr`.`target_id`) and (`p`.`parent_id` = `f`.`ID`) and (`p`.`depth` > 1) and (`f`.`afun` = _latin1'Coord')) order by `tr`.`root_id` */;

--
-- Final view structure for view `Target1`
--

/*!50001 DROP TABLE IF EXISTS `Target1`*/;
/*!50001 DROP VIEW IF EXISTS `Target1`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Target1` AS select `Forma`.`ID` AS `ID`,`Forma`.`forma` AS `forma`,`Forma`.`lemma` AS `lemma`,`Forma`.`pos` AS `pos`,`Forma`.`grado_nom` AS `grado_nom`,`Forma`.`cat_fl` AS `cat_fl`,`Forma`.`modo` AS `modo`,`Forma`.`tempo` AS `tempo`,`Forma`.`grado_part` AS `grado_part`,`Forma`.`caso` AS `caso`,`Forma`.`gen_num` AS `gen_num`,`Forma`.`comp` AS `comp`,`Forma`.`variaz` AS `variaz`,`Forma`.`variaz_graf` AS `variaz_graf`,`Forma`.`afun` AS `afun`,`Forma`.`rank` AS `rank`,`Forma`.`gov` AS `gov`,`Forma`.`frase` AS `frase` from `Forma` where ((`Forma`.`afun` like _latin1'Sb_%') or (`Forma`.`afun` like _latin1'Obj_%') or (`Forma`.`afun` like _latin1'Pnom_%') or (`Forma`.`afun` like _latin1'OComp_%')) */;

--
-- Final view structure for view `Target2`
--

/*!50001 DROP TABLE IF EXISTS `Target2`*/;
/*!50001 DROP VIEW IF EXISTS `Target2`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Target2` AS select `Forma`.`ID` AS `ID`,`Forma`.`forma` AS `forma`,`Forma`.`lemma` AS `lemma`,`Forma`.`pos` AS `pos`,`Forma`.`grado_nom` AS `grado_nom`,`Forma`.`cat_fl` AS `cat_fl`,`Forma`.`modo` AS `modo`,`Forma`.`tempo` AS `tempo`,`Forma`.`grado_part` AS `grado_part`,`Forma`.`caso` AS `caso`,`Forma`.`gen_num` AS `gen_num`,`Forma`.`comp` AS `comp`,`Forma`.`variaz` AS `variaz`,`Forma`.`variaz_graf` AS `variaz_graf`,`Forma`.`afun` AS `afun`,`Forma`.`rank` AS `rank`,`Forma`.`gov` AS `gov`,`Forma`.`frase` AS `frase` from `Forma` where (`Forma`.`afun` in (_latin1'Sb',_latin1'Obj',_latin1'Pnom',_latin1'OComp')) */;

--
-- Final view structure for view `TargetRoot`
--

/*!50001 DROP TABLE IF EXISTS `TargetRoot`*/;
/*!50001 DROP VIEW IF EXISTS `TargetRoot`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `TargetRoot` AS select `Path`.`target_id` AS `target_id`,`Path`.`parent_id` AS `root_id` from `Path` where (`Path`.`depth` = 1) */;

--
-- Final view structure for view `TreeView_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `TreeView_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `TreeView_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `TreeView_conusintr` AS select `f`.`ID` AS `root_id`,`f`.`lemma` AS `verbo`,`f`.`diatesi` AS `diatesi`,_latin1'V' AS `scf1`,_latin1'V' AS `scc1`,_latin1'--' AS `scc4`,concat_ws(_latin1'_',`f`.`diatesi_nondep`,_latin1'V') AS `scc4_diat_nondep`,concat_ws(_latin1'_',`f`.`diatesi`,_latin1'V') AS `scc4_diat`,_latin1'V' AS `scf2`,_latin1'V' AS `scc2`,_latin1'V' AS `scc3` from (`myViewForma` `f` left join `TreeView` `t` on((`f`.`ID` = `t`.`root_id`))) where (isnull(`t`.`root_id`) and ((`f`.`pos` = _latin1'Vb') or (`f`.`pos` = _latin1'Pt'))) */;

--
-- Final view structure for view `Verbo`
--

/*!50001 DROP TABLE IF EXISTS `Verbo`*/;
/*!50001 DROP VIEW IF EXISTS `Verbo`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Verbo` AS select `Forma`.`ID` AS `ID`,`Forma`.`forma` AS `forma`,`Forma`.`lemma` AS `lemma`,`Forma`.`pos` AS `pos`,`Forma`.`grado_nom` AS `grado_nom`,`Forma`.`cat_fl` AS `cat_fl`,`Forma`.`modo` AS `modo`,`Forma`.`tempo` AS `tempo`,`Forma`.`grado_part` AS `grado_part`,`Forma`.`caso` AS `caso`,`Forma`.`gen_num` AS `gen_num`,`Forma`.`comp` AS `comp`,`Forma`.`variaz` AS `variaz`,`Forma`.`variaz_graf` AS `variaz_graf`,`Forma`.`afun` AS `afun`,`Forma`.`rank` AS `rank`,`Forma`.`gov` AS `gov`,`Forma`.`frase` AS `frase` from `Forma` where ((`Forma`.`pos` = _latin1'2') or (`Forma`.`pos` = 3)) */;

--
-- Final view structure for view `fillers_scc1`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scc1`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scc1`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scc1` AS select `fr`.`lemma` AS `verbo`,`fr`.`diatesi` AS `diatesi`,`tr`.`scc1` AS `scc1`,concat_ws(_latin1'_',`fr`.`diatesi`,`tr`.`scc1`) AS `scc1_diat`,`F`.`root_id` AS `root_id`,`F`.`fillers_auxpc_coordapos_scc1` AS `fillers_auxpc_coordapos_scc1`,`F`.`fillers_verbo_scc1` AS `fillers_verbo_scc1`,`F`.`fillers_scc1` AS `fillers_scc1`,`F`.`caso_scc1` AS `caso_scc1`,`F`.`caso_modo_scc1` AS `caso_modo_scc1`,`F`.`afun_caso_scc1` AS `afun_caso_scc1`,`F`.`afun_caso_modo_scc1` AS `afun_caso_modo_scc1`,`F`.`caso_fillers_scc1` AS `caso_fillers_scc1`,`F`.`caso_modo_fillers_scc1` AS `caso_modo_fillers_scc1`,`F`.`completo_nomodo_fillers_scc1` AS `completo_nomodo_fillers_scc1`,`F`.`completo_fillers_scc1` AS `completo_fillers_scc1` from ((`Tfillers_scc1` `F` join `myViewForma` `fr`) join `TreeView` `tr`) where ((`F`.`root_id` = `fr`.`ID`) and (`F`.`root_id` = `tr`.`root_id`)) */;

--
-- Final view structure for view `fillers_scc1_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scc1_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scc1_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scc1_conusintr` AS select `f`.`ID` AS `root_id`,`f`.`lemma` AS `verbo`,`f`.`diatesi` AS `diatesi`,_latin1'V' AS `scc1`,concat_ws(_latin1'_',`f`.`diatesi`,_latin1'V') AS `scc1_diat`,_latin1'V' AS `fillers_auxpc_coordapos_scc1`,concat(_latin1'V[',`f`.`lemma`,_latin1']') AS `fillers_verbo_scc1`,_latin1'--' AS `fillers_scc1`,_latin1'--' AS `caso_scc1`,_latin1'--' AS `caso_modo_scc1`,_latin1'V' AS `afun_caso_scc1`,_latin1'V' AS `afun_caso_modo_scc1`,_latin1'--' AS `caso_fillers_scc1`,_latin1'--' AS `caso_modo_fillers_scc1`,concat(_latin1'[',`f`.`diatesi`,_latin1']') AS `completo_nomodo_fillers_scc1`,concat(_latin1'[',`f`.`diatesi`,_latin1']') AS `completo_fillers_scc1` from (`myViewForma` `f` left join `fillers_scc1` on((`f`.`ID` = `fillers_scc1`.`root_id`))) where (isnull(`fillers_scc1`.`root_id`) and ((`f`.`pos` = _latin1'Vb') or (`f`.`pos` = _latin1'Pt'))) */;

--
-- Final view structure for view `fillers_scc2`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scc2`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scc2`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scc2` AS select `fr`.`lemma` AS `verbo`,`fr`.`diatesi` AS `diatesi`,`tr`.`scc2` AS `scc2`,concat_ws(_latin1'_',`fr`.`diatesi`,`tr`.`scc2`) AS `scc2_diat`,`F`.`root_id` AS `root_id`,`F`.`fillers_verbo_scc2` AS `fillers_verbo_scc2`,`F`.`fillers_scc2` AS `fillers_scc2`,`F`.`caso_scc2` AS `caso_scc2`,`F`.`caso_modo_scc2` AS `caso_modo_scc2`,`F`.`afun_caso_scc2` AS `afun_caso_scc2`,`F`.`afun_caso_modo_scc2` AS `afun_caso_modo_scc2`,`F`.`caso_fillers_scc2` AS `caso_fillers_scc2`,`F`.`caso_modo_fillers_scc2` AS `caso_modo_fillers_scc2`,`F`.`completo_nomodo_fillers_scc2` AS `completo_nomodo_fillers_scc2`,`F`.`completo_fillers_scc2` AS `completo_fillers_scc2` from ((`Tfillers_scc2` `F` join `myViewForma` `fr`) join `TreeView` `tr`) where ((`F`.`root_id` = `fr`.`ID`) and (`F`.`root_id` = `tr`.`root_id`)) */;

--
-- Final view structure for view `fillers_scc2_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scc2_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scc2_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scc2_conusintr` AS select `f`.`ID` AS `root_id`,`f`.`lemma` AS `verbo`,`f`.`diatesi` AS `diatesi`,_latin1'V' AS `scc2`,concat_ws(_latin1'_',`f`.`diatesi`,_latin1'V') AS `scc2_diat`,concat(_latin1'V[',`f`.`lemma`,_latin1']') AS `fillers_verbo_scc2`,_latin1'--' AS `fillers_scc2`,_latin1'--' AS `caso_scc2`,_latin1'--' AS `caso_modo_scc2`,_latin1'V' AS `afun_caso_scc2`,_latin1'V' AS `afun_caso_modo_scc2`,_latin1'--' AS `caso_fillers_scc2`,_latin1'--' AS `caso_modo_fillers_scc2`,concat(_latin1'[',`f`.`diatesi`,_latin1']') AS `completo_nomodo_fillers_scc2`,concat(_latin1'[',`f`.`diatesi`,_latin1']') AS `completo_fillers_scc2` from (`myViewForma` `f` left join `fillers_scc2` on((`f`.`ID` = `fillers_scc2`.`root_id`))) where (isnull(`fillers_scc2`.`root_id`) and ((`f`.`pos` = _latin1'Vb') or (`f`.`pos` = _latin1'Pt'))) */;

--
-- Final view structure for view `fillers_scc3`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scc3`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scc3`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scc3` AS select `fr`.`lemma` AS `verbo`,`fr`.`diatesi` AS `diatesi`,`tr`.`scc3` AS `scc3`,concat_ws(_latin1'_',`fr`.`diatesi`,`tr`.`scc3`) AS `scc3_diat`,`F`.`root_id` AS `root_id`,`F`.`fillers_verbo_scc3` AS `fillers_verbo_scc3`,`F`.`fillers_scc3` AS `fillers_scc3`,`F`.`caso_scc3` AS `caso_scc3`,`F`.`caso_modo_scc3` AS `caso_modo_scc3`,`F`.`afun_caso_modo_scc3` AS `afun_caso_modo_scc3`,`F`.`caso_fillers_scc3` AS `caso_fillers_scc3`,`F`.`caso_modo_fillers_scc3` AS `caso_modo_fillers_scc3`,`F`.`completo_fillers_scc3` AS `completo_fillers_scc3` from ((`Tfillers_scc3` `F` join `myViewForma` `fr`) join `TreeView` `tr`) where ((`F`.`root_id` = `fr`.`ID`) and (`F`.`root_id` = `tr`.`root_id`)) */;

--
-- Final view structure for view `fillers_scc3_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scc3_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scc3_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scc3_conusintr` AS select `f`.`ID` AS `root_id`,`f`.`lemma` AS `verbo`,`f`.`diatesi` AS `diatesi`,_latin1'V' AS `scc3`,concat_ws(_latin1'_',`f`.`diatesi`,_latin1'V') AS `scc3_diat`,concat(_latin1'V[',`f`.`lemma`,_latin1']') AS `fillers_verbo_scc3`,_latin1'--' AS `fillers_scc3`,_latin1'--' AS `caso_scc3`,_latin1'--' AS `caso_modo_scc3`,_latin1'V' AS `afun_caso_modo_scc3`,_latin1'--' AS `caso_fillers_scc3`,_latin1'--' AS `caso_modo_fillers_scc3`,concat(_latin1'[',`f`.`diatesi`,_latin1']') AS `completo_fillers_scc3` from (`myViewForma` `f` left join `fillers_scc3` on((`f`.`ID` = `fillers_scc3`.`root_id`))) where (isnull(`fillers_scc3`.`root_id`) and ((`f`.`pos` = _latin1'Vb') or (`f`.`pos` = _latin1'Pt'))) */;

--
-- Final view structure for view `fillers_scc4`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scc4`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scc4`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scc4` AS select `fr`.`lemma` AS `verbo`,`fr`.`diatesi` AS `diatesi`,`tr`.`scc4` AS `scc4`,concat_ws(_latin1'_',`fr`.`diatesi_nondep`,`tr`.`scc4`) AS `scc4_diat_nondep`,concat_ws(_latin1'_',`fr`.`diatesi_nondep`,`tr`.`scc4`) AS `scc4_diat`,concat_ws(_latin1'_',`fr`.`diatesi`,`F`.`_afun_caso_modo_scc4_diat`) AS `afun_caso_modo_scc4_diat`,concat_ws(_latin1'_',`fr`.`diatesi`,`F`.`_completo_fillers_scc4`) AS `completo_Tfillers_scc4`,`F`.`root_id` AS `root_id`,`F`.`_afun_caso_modo_scc4_diat` AS `_afun_caso_modo_scc4_diat`,`F`.`_completo_fillers_scc4` AS `_completo_fillers_scc4`,`F`.`lista_fillers_scc4` AS `lista_fillers_scc4`,`F`.`lista_fillersafunptgg_novb_scc4` AS `lista_fillersafunptgg_novb_scc4`,`F`.`lista_fillersafun_novb_scc4` AS `lista_fillersafun_novb_scc4`,`F`.`lista_fillers_novb_scc4` AS `lista_fillers_novb_scc4`,`F`.`lista_fillers_novbpt_scc4` AS `lista_fillers_novbpt_scc4` from ((`Tfillers_scc4` `F` join `myViewForma` `fr`) join `TreeView` `tr`) where ((`F`.`root_id` = `fr`.`ID`) and (`F`.`root_id` = `tr`.`root_id`)) */;

--
-- Final view structure for view `fillers_scf1`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scf1`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scf1`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scf1` AS select `fr`.`lemma` AS `verbo`,`fr`.`diatesi` AS `diatesi`,`tr`.`scf1` AS `scf1`,concat_ws(_latin1'_',`fr`.`diatesi`,`tr`.`scf1`) AS `scf1_diat`,`F`.`root_id` AS `root_id`,`F`.`fillers_auxpc_coordapos_scf1` AS `fillers_auxpc_coordapos_scf1`,`F`.`fillers_verbo_scf1` AS `fillers_verbo_scf1`,`F`.`fillers_scf1` AS `fillers_scf1`,`F`.`caso_scf1` AS `caso_scf1`,`F`.`caso_modo_scf1` AS `caso_modo_scf1`,`F`.`afun_caso_scf1` AS `afun_caso_scf1`,`F`.`afun_caso_modo_scf1` AS `afun_caso_modo_scf1`,`F`.`caso_fillers_scf1` AS `caso_fillers_scf1`,`F`.`caso_modo_fillers_scf1` AS `caso_modo_fillers_scf1`,`F`.`completo_nomodo_fillers_scf1` AS `completo_nomodo_fillers_scf1`,`F`.`completo_fillers_scf1` AS `completo_fillers_scf1` from ((`Tfillers_scf1` `F` join `myViewForma` `fr`) join `TreeView` `tr`) where ((`F`.`root_id` = `fr`.`ID`) and (`F`.`root_id` = `tr`.`root_id`)) */;

--
-- Final view structure for view `fillers_scf1_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scf1_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scf1_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scf1_conusintr` AS select `f`.`ID` AS `root_id`,`f`.`lemma` AS `verbo`,`f`.`diatesi` AS `diatesi`,_latin1'V' AS `scf1`,concat_ws(_latin1'_',`f`.`diatesi`,_latin1'V') AS `scf1_diat`,_latin1'V' AS `fillers_auxpc_coordapos_scf1`,concat(_latin1'V[',`f`.`lemma`,_latin1']') AS `fillers_verbo_scf1`,_latin1'--' AS `fillers_scf1`,_latin1'--' AS `caso_scf1`,_latin1'--' AS `caso_modo_scf1`,_latin1'V' AS `afun_caso_scf1`,_latin1'V' AS `afun_caso_modo_scf1`,_latin1'--' AS `caso_fillers_scf1`,_latin1'--' AS `caso_modo_fillers_scf1`,concat(_latin1'[',`f`.`diatesi`,_latin1']') AS `completo_nomodo_fillers_scf1`,concat(_latin1'[',`f`.`diatesi`,_latin1']') AS `completo_fillers_scf1` from (`myViewForma` `f` left join `fillers_scf1` on((`f`.`ID` = `fillers_scf1`.`root_id`))) where (isnull(`fillers_scf1`.`root_id`) and ((`f`.`pos` = _latin1'Vb') or (`f`.`pos` = _latin1'Pt'))) */;

--
-- Final view structure for view `fillers_scf2`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scf2`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scf2`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scf2` AS select `fr`.`lemma` AS `verbo`,`fr`.`diatesi` AS `diatesi`,`tr`.`scf2` AS `scf2`,concat_ws(_latin1'_',`fr`.`diatesi`,`tr`.`scf2`) AS `scf2_diat`,`F`.`root_id` AS `root_id`,`F`.`fillers_scf2` AS `fillers_scf2`,`F`.`fillers_verbo_scf2` AS `fillers_verbo_scf2`,`F`.`caso_scf2` AS `caso_scf2`,`F`.`caso_modo_scf2` AS `caso_modo_scf2`,`F`.`afun_caso_scf2` AS `afun_caso_scf2`,`F`.`afun_caso_modo_scf2` AS `afun_caso_modo_scf2`,`F`.`caso_fillers_scf2` AS `caso_fillers_scf2`,`F`.`caso_modo_fillers_scf2` AS `caso_modo_fillers_scf2`,`F`.`completo_nomodo_fillers_scf2` AS `completo_nomodo_fillers_scf2`,`F`.`completo_fillers_scf2` AS `completo_fillers_scf2` from ((`Tfillers_scf2` `F` join `myViewForma` `fr`) join `TreeView` `tr`) where ((`F`.`root_id` = `fr`.`ID`) and (`F`.`root_id` = `tr`.`root_id`)) */;

--
-- Final view structure for view `fillers_scf2_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `fillers_scf2_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `fillers_scf2_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fillers_scf2_conusintr` AS select `f`.`ID` AS `root_id`,`f`.`lemma` AS `verbo`,`f`.`diatesi` AS `diatesi`,_latin1'V' AS `scf2`,concat_ws(_latin1'_',`f`.`diatesi`,_latin1'V') AS `scf2_diat`,concat(_latin1'V[',`f`.`lemma`,_latin1']') AS `fillers_verbo_scf2`,_latin1'--' AS `fillers_scf2`,_latin1'--' AS `caso_scf2`,_latin1'--' AS `caso_modo_scf2`,_latin1'V' AS `afun_caso_scf2`,_latin1'V' AS `afun_caso_modo_scf2`,_latin1'--' AS `caso_fillers_scf2`,_latin1'--' AS `caso_modo_fillers_scf2`,concat(_latin1'[',`f`.`diatesi`,_latin1']') AS `completo_nomodo_fillers_scf2`,concat(_latin1'[',`f`.`diatesi`,_latin1']') AS `completo_fillers_scf2` from (`myViewForma` `f` left join `fillers_scf2` on((`f`.`ID` = `fillers_scf2`.`root_id`))) where (isnull(`fillers_scf2`.`root_id`) and ((`f`.`pos` = _latin1'Vb') or (`f`.`pos` = _latin1'Pt'))) */;

--
-- Final view structure for view `freq_scc1`
--

/*!50001 DROP TABLE IF EXISTS `freq_scc1`*/;
/*!50001 DROP VIEW IF EXISTS `freq_scc1`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_scc1` AS select `fillers_scc1`.`scc1_diat` AS `scc1_diat`,count(0) AS `freq_scc1_diat` from `fillers_scc1` group by `fillers_scc1`.`scc1_diat` order by `fillers_scc1`.`scc1_diat` */;

--
-- Final view structure for view `freq_scc2`
--

/*!50001 DROP TABLE IF EXISTS `freq_scc2`*/;
/*!50001 DROP VIEW IF EXISTS `freq_scc2`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_scc2` AS select `fillers_scc2`.`scc2_diat` AS `scc2_diat`,count(0) AS `freq_scc2_diat` from `fillers_scc2` group by `fillers_scc2`.`scc2_diat` order by `fillers_scc2`.`scc2_diat` */;

--
-- Final view structure for view `freq_scc3`
--

/*!50001 DROP TABLE IF EXISTS `freq_scc3`*/;
/*!50001 DROP VIEW IF EXISTS `freq_scc3`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_scc3` AS select `fillers_scc3`.`scc3_diat` AS `scc3_diat`,count(0) AS `freq_scc3_diat` from `fillers_scc3` group by `fillers_scc3`.`scc3_diat` order by `fillers_scc3`.`scc3_diat` */;

--
-- Final view structure for view `freq_scf1`
--

/*!50001 DROP TABLE IF EXISTS `freq_scf1`*/;
/*!50001 DROP VIEW IF EXISTS `freq_scf1`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_scf1` AS select `fillers_scf1`.`scf1_diat` AS `scf1_diat`,count(0) AS `freq_scf1_diat` from `fillers_scf1` group by `fillers_scf1`.`scf1_diat` order by `fillers_scf1`.`scf1_diat` */;

--
-- Final view structure for view `freq_scf2`
--

/*!50001 DROP TABLE IF EXISTS `freq_scf2`*/;
/*!50001 DROP VIEW IF EXISTS `freq_scf2`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_scf2` AS select `fillers_scf2`.`scf2_diat` AS `scf2_diat`,count(0) AS `freq_scf2_diat` from `fillers_scf2` group by `fillers_scf2`.`scf2_diat` order by `fillers_scf2`.`scf2_diat` */;

--
-- Final view structure for view `freq_verbo_scc1`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scc1`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc1`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scc1` AS select `fillers_scc1`.`verbo` AS `verbo`,`fillers_scc1`.`scc1_diat` AS `scc1_diat`,count(`fillers_scc1`.`scc1_diat`) AS `freq_verbo_scc1_diat` from `fillers_scc1` group by `fillers_scc1`.`verbo`,`fillers_scc1`.`scc1_diat` order by `fillers_scc1`.`verbo`,count(`fillers_scc1`.`scc1_diat`) desc */;

--
-- Final view structure for view `freq_verbo_scc1_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scc1_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc1_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scc1_conusintr` AS select `fillers_scc1_conusintr`.`verbo` AS `verbo`,`fillers_scc1_conusintr`.`scc1_diat` AS `scc1_diat`,count(`fillers_scc1_conusintr`.`scc1_diat`) AS `freq_verbo_scc1_diat` from `fillers_scc1_conusintr` group by `fillers_scc1_conusintr`.`verbo`,`fillers_scc1_conusintr`.`scc1_diat` order by `fillers_scc1_conusintr`.`verbo`,count(`fillers_scc1_conusintr`.`scc1_diat`) desc */;

--
-- Final view structure for view `freq_verbo_scc2`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scc2`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc2`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scc2` AS select `fillers_scc2`.`verbo` AS `verbo`,`fillers_scc2`.`scc2_diat` AS `scc2_diat`,count(`fillers_scc2`.`scc2_diat`) AS `freq_verbo_scc2_diat` from `fillers_scc2` group by `fillers_scc2`.`verbo`,`fillers_scc2`.`scc2_diat` order by `fillers_scc2`.`verbo`,count(`fillers_scc2`.`scc2_diat`) desc */;

--
-- Final view structure for view `freq_verbo_scc2_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scc2_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc2_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scc2_conusintr` AS select `fillers_scc2_conusintr`.`verbo` AS `verbo`,`fillers_scc2_conusintr`.`scc2_diat` AS `scc2_diat`,count(`fillers_scc2_conusintr`.`scc2_diat`) AS `freq_verbo_scc2_diat` from `fillers_scc2_conusintr` group by `fillers_scc2_conusintr`.`verbo`,`fillers_scc2_conusintr`.`scc2_diat` order by `fillers_scc2_conusintr`.`verbo`,count(`fillers_scc2_conusintr`.`scc2_diat`) desc */;

--
-- Final view structure for view `freq_verbo_scc3`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scc3`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc3`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scc3` AS select `fillers_scc3`.`verbo` AS `verbo`,`fillers_scc3`.`scc3_diat` AS `scc3_diat`,count(`fillers_scc3`.`scc3_diat`) AS `freq_verbo_scc3_diat` from `fillers_scc3` group by `fillers_scc3`.`verbo`,`fillers_scc3`.`scc3_diat` order by `fillers_scc3`.`verbo`,count(`fillers_scc3`.`scc3_diat`) desc */;

--
-- Final view structure for view `freq_verbo_scc3_afuncasomodo`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scc3_afuncasomodo`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc3_afuncasomodo`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scc3_afuncasomodo` AS select `fillers_scc3`.`verbo` AS `verbo`,`fillers_scc3`.`diatesi` AS `diatesi`,`fillers_scc3`.`afun_caso_modo_scc3` AS `afun_caso_modo_scc3`,count(`fillers_scc3`.`afun_caso_modo_scc3`) AS `freq_verbo_scc3_afun_caso_modo` from `fillers_scc3` group by `fillers_scc3`.`verbo`,`fillers_scc3`.`afun_caso_modo_scc3` order by `fillers_scc3`.`verbo`,`fillers_scc3`.`afun_caso_modo_scc3` desc */;

--
-- Final view structure for view `freq_verbo_scc3_afuncasomodo_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scc3_afuncasomodo_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc3_afuncasomodo_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scc3_afuncasomodo_conusintr` AS select `fillers_scc3_conusintr`.`verbo` AS `verbo`,`fillers_scc3_conusintr`.`diatesi` AS `diatesi`,`fillers_scc3_conusintr`.`afun_caso_modo_scc3` AS `afun_caso_modo_scc3`,count(`fillers_scc3_conusintr`.`afun_caso_modo_scc3`) AS `freq_verbo_scc3_afun_caso_modo` from `fillers_scc3_conusintr` group by `fillers_scc3_conusintr`.`verbo`,`fillers_scc3_conusintr`.`afun_caso_modo_scc3` order by `fillers_scc3_conusintr`.`verbo`,`fillers_scc3_conusintr`.`afun_caso_modo_scc3` desc */;

--
-- Final view structure for view `freq_verbo_scc3_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scc3_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scc3_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scc3_conusintr` AS select `fillers_scc3_conusintr`.`verbo` AS `verbo`,`fillers_scc3_conusintr`.`scc3_diat` AS `scc3_diat`,count(`fillers_scc3_conusintr`.`scc3_diat`) AS `freq_verbo_scc3_diat` from `fillers_scc3_conusintr` group by `fillers_scc3_conusintr`.`verbo`,`fillers_scc3_conusintr`.`scc3_diat` order by `fillers_scc3_conusintr`.`verbo`,count(`fillers_scc3_conusintr`.`scc3_diat`) desc */;

--
-- Final view structure for view `freq_verbo_scf1`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scf1`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scf1`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scf1` AS select `fillers_scf1`.`verbo` AS `verbo`,`fillers_scf1`.`scf1_diat` AS `scf1_diat`,count(`fillers_scf1`.`scf1_diat`) AS `freq_verbo_scf1_diat` from `fillers_scf1` group by `fillers_scf1`.`verbo`,`fillers_scf1`.`scf1_diat` order by `fillers_scf1`.`verbo`,count(`fillers_scf1`.`scf1_diat`) desc */;

--
-- Final view structure for view `freq_verbo_scf1_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scf1_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scf1_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scf1_conusintr` AS select `fillers_scf1_conusintr`.`verbo` AS `verbo`,`fillers_scf1_conusintr`.`scf1_diat` AS `scf1_diat`,count(`fillers_scf1_conusintr`.`scf1_diat`) AS `freq_verbo_scf1_diat` from `fillers_scf1_conusintr` group by `fillers_scf1_conusintr`.`verbo`,`fillers_scf1_conusintr`.`scf1_diat` order by `fillers_scf1_conusintr`.`verbo`,count(`fillers_scf1_conusintr`.`scf1_diat`) desc */;

--
-- Final view structure for view `freq_verbo_scf2`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scf2`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scf2`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scf2` AS select `fillers_scf2`.`verbo` AS `verbo`,`fillers_scf2`.`scf2_diat` AS `scf2_diat`,count(`fillers_scf2`.`scf2_diat`) AS `freq_verbo_scf2_diat` from `fillers_scf2` group by `fillers_scf2`.`verbo`,`fillers_scf2`.`scf2_diat` order by `fillers_scf2`.`verbo`,count(`fillers_scf2`.`scf2_diat`) desc */;

--
-- Final view structure for view `freq_verbo_scf2_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `freq_verbo_scf2_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `freq_verbo_scf2_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `freq_verbo_scf2_conusintr` AS select `fillers_scf2_conusintr`.`verbo` AS `verbo`,`fillers_scf2_conusintr`.`scf2_diat` AS `scf2_diat`,count(`fillers_scf2_conusintr`.`scf2_diat`) AS `freq_verbo_scf2_diat` from `fillers_scf2_conusintr` group by `fillers_scf2_conusintr`.`verbo`,`fillers_scf2_conusintr`.`scf2_diat` order by `fillers_scf2_conusintr`.`verbo`,count(`fillers_scf2_conusintr`.`scf2_diat`) desc */;

--
-- Final view structure for view `frequenze_verbo`
--

/*!50001 DROP TABLE IF EXISTS `frequenze_verbo`*/;
/*!50001 DROP VIEW IF EXISTS `frequenze_verbo`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `frequenze_verbo` AS select `f`.`lemma` AS `verbo`,count(0) AS `freq_verbo` from (`lessico_valenza_conusintr_condiat` `l` join `myViewForma` `f`) where (`l`.`ID` = `f`.`ID`) group by `f`.`lemma` order by count(0) desc */;

--
-- Final view structure for view `lessico_valenza`
--

/*!50001 DROP TABLE IF EXISTS `lessico_valenza`*/;
/*!50001 DROP VIEW IF EXISTS `lessico_valenza`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `lessico_valenza` AS select `f`.`lemma` AS `lemma`,`f`.`ID` AS `ID`,`t`.`scf1` AS `scf1`,`t`.`scc1` AS `scc1`,`t`.`scf2` AS `scf2`,`t`.`scc2` AS `scc2`,`t`.`scc3` AS `scc3`,`t`.`scc4` AS `scc4`,`f`.`frase` AS `frase` from (`TreeView` `t` join `Forma` `f`) where (`t`.`root_id` = `f`.`ID`) order by `f`.`lemma` */;

--
-- Final view structure for view `lessico_valenza_conusintr`
--

/*!50001 DROP TABLE IF EXISTS `lessico_valenza_conusintr`*/;
/*!50001 DROP VIEW IF EXISTS `lessico_valenza_conusintr`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `lessico_valenza_conusintr` AS select `f`.`lemma` AS `lemma`,`t`.`diatesi` AS `diatesi`,`f`.`ID` AS `ID`,`t`.`scf1` AS `scf1`,`t`.`scc1` AS `scc1`,`t`.`scf2` AS `scf2`,`t`.`scc2` AS `scc2`,`t`.`scc3` AS `scc3`,`t`.`scc4` AS `scc4`,`f`.`frase` AS `frase` from (`TreeView_conusintr` `t` join `Forma` `f`) where (`t`.`root_id` = `f`.`ID`) order by `f`.`lemma` */;

--
-- Final view structure for view `lessico_valenza_conusintr_condiat`
--

/*!50001 DROP TABLE IF EXISTS `lessico_valenza_conusintr_condiat`*/;
/*!50001 DROP VIEW IF EXISTS `lessico_valenza_conusintr_condiat`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `lessico_valenza_conusintr_condiat` AS select `f`.`lemma` AS `lemma`,`f`.`ID` AS `ID`,concat(`t`.`diatesi`,_latin1'_',`t`.`scf1`) AS `scf1_diat`,concat(`t`.`diatesi`,_latin1'_',`t`.`scc1`) AS `scc1_diat`,concat(`t`.`diatesi`,_latin1'_',`t`.`scf2`) AS `scf2_diat`,concat(`t`.`diatesi`,_latin1'_',`t`.`scc2`) AS `scc2_diat`,concat(`t`.`diatesi`,_latin1'_',`t`.`scc3`) AS `scc3_diat`,concat(`t`.`diatesi`,_latin1'_',`t`.`scc4`) AS `scc4_diat`,`f`.`frase` AS `frase` from (`TreeView_conusintr` `t` join `Forma` `f`) where (`t`.`root_id` = `f`.`ID`) order by `f`.`lemma` */;

--
-- Final view structure for view `myViewForma`
--

/*!50001 DROP TABLE IF EXISTS `myViewForma`*/;
/*!50001 DROP VIEW IF EXISTS `myViewForma`*/;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `myViewForma` AS select `Formanuova`.`ID` AS `ID`,`Formanuova`.`pos` AS `pos`,`Formanuova`.`forma` AS `forma`,`Formanuova`.`lemma` AS `lemma`,`Formanuova`.`afun` AS `afun`,`Formanuova`.`afunsenzacoap` AS `afunsenzacoap`,`Formanuova`.`rank` AS `rank`,`Formanuova`.`modo` AS `modo`,`Formanuova`.`caso` AS `caso`,`Formanuova`.`caso_modo` AS `caso_modo`,`Formanuova`.`diatesi` AS `diatesi`,`Formanuova`.`diatesi_nondep` AS `diatesi_nondep`,concat_ws(_latin1'#',_latin1'',concat_ws(_latin1'#§',`Formanuova`.`caso`,concat_ws(_latin1'§',`Formanuova`.`lemma`,_latin1''))) AS `caso_lemma`,concat_ws(_latin1'#',_latin1'',concat_ws(_latin1'#§',`Formanuova`.`caso_modo`,concat_ws(_latin1'§',`Formanuova`.`lemma`,_latin1''))) AS `caso_modo_lemma`,concat_ws(_latin1'*',_latin1'',concat_ws(_latin1'*#',`Formanuova`.`afun`,concat_ws(_latin1'#',`Formanuova`.`caso`,_latin1''))) AS `afun_caso`,concat_ws(_latin1'*',_latin1'',concat_ws(_latin1'*#',`Formanuova`.`afun`,concat_ws(_latin1'#',`Formanuova`.`caso_modo`,_latin1''))) AS `afun_caso_modo`,concat_ws(_latin1'*',_latin1'',concat_ws(_latin1'*#',`Formanuova`.`afunsenzacoap`,concat_ws(_latin1'#',`Formanuova`.`caso_modo`,_latin1''))) AS `afun_caso_modo_senzacoap`,concat_ws(_latin1'*',_latin1'',concat_ws(_latin1'*#',`Formanuova`.`afun`,concat_ws(_latin1'#§',`Formanuova`.`caso`,concat_ws(_latin1'§°',`Formanuova`.`lemma`)))) AS `info_forma_nomodo`,concat_ws(_latin1'*',_latin1'',concat_ws(_latin1'*#',`Formanuova`.`afun`,concat_ws(_latin1'#§',`Formanuova`.`caso_modo`,concat_ws(_latin1'§°',`Formanuova`.`lemma`)))) AS `info_forma`,concat_ws(_latin1'*',_latin1'',concat_ws(_latin1'*#',`Formanuova`.`afunsenzacoap`,concat_ws(_latin1'#§',`Formanuova`.`caso_modo`,concat_ws(_latin1'§°',`Formanuova`.`lemma`)))) AS `info_forma_senzacoap`,`Formanuova`.`frase` AS `frase` from `Formanuova` */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-05-12  0:59:26
