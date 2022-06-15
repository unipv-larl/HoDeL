-- craeazione tabella treeview 

DROP TABLE IF EXISTS TreeView;

CREATE TABLE TreeView (
  `root_id` int(10) unsigned,
   scf1 CHAR(255),
   scc1 CHAR(255),
   scf2 CHAR(255),
   scc2 CHAR(255),
   scc3 CHAR(255),
   scc4 CHAR(255),
   UNIQUE INDEX (root_id),
   FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

