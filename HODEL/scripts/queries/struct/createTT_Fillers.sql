DROP TABLE IF EXISTS Tfillers_scc1;
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
   UNIQUE INDEX (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Tfillers_scc2;
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
   UNIQUE INDEX (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Tfillers_scc3;
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
   UNIQUE INDEX (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Tfillers_scc4;
CREATE TABLE `Tfillers_scc4` (
  `root_id` int(10) unsigned NOT NULL default '0',
  `_afun_caso_modo_scc4_diat` varchar(256) default NULL,
  `_completo_fillers_scc4` varchar(256) default NULL,
  `lista_fillers_scc4` longtext,
  `lista_fillersafunptgg_novb_scc4` longtext,
  `lista_fillersafun_novb_scc4` longtext,
  `lista_fillers_novb_scc4` longtext,
  `lista_fillers_novbpt_scc4` longtext,
   UNIQUE INDEX (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Tfillers_scf1;
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
   UNIQUE INDEX (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS Tfillers_scf2;
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
   UNIQUE INDEX (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

