
-- tabella dei percorsi
DROP TABLE IF EXISTS Path;

CREATE TABLE Path (
--  root_id int(10) unsigned NOT NULL default '0',
  root_id int(10) unsigned default '0',
  target_id int(10) unsigned NOT NULL default '0',
  parent_id int(10) unsigned default '0',
  depth int(10) unsigned NOT NULL default '0',
  INDEX (root_id),
  INDEX (target_id),
  INDEX (parent_id),
  FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE  CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (target_id) REFERENCES Forma(ID) ON DELETE  CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (parent_id) REFERENCES Forma(ID) ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- tabella riassuntiva : root_id, target_id, parent_id, alias   
DROP TABLE IF EXISTS Summa;
CREATE TABLE Summa (
  root_id int(10) unsigned NOT NULL default '0',
  target_id int(10) unsigned NOT NULL default '0',
  parent_id int(10) unsigned default '0',
  depth int(10) unsigned NOT NULL default '0',
--  alias int(10) unsigned NOT NULL default '0',
  alias int(10) unsigned default '0',
  INDEX (root_id),
  INDEX (target_id),
  INDEX (parent_id),
  FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE  CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (target_id) REFERENCES Forma(ID) ON DELETE  CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (parent_id) REFERENCES Forma(ID) ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- crea tabella degli alias per ciascun 'coord' ambiguo per albero
DROP TABLE IF EXISTS RootCoordIndex;

CREATE TABLE RootCoordIndex (
  root_id int(10) unsigned NOT NULL default '0',
  coord_id int(10) unsigned default '0',
  alias int(10) unsigned NOT NULL default '0',
  INDEX (root_id),
  INDEX (coord_id),
  FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE  CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (coord_id) REFERENCES Forma(ID) ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- crea tabella degli alias per ciascun 'coord' ambiguo per target
DROP TABLE IF EXISTS TargetCoord;

CREATE TABLE TargetCoord (
  target_id int(10) unsigned NOT NULL default '0',
  coord_id int(10) unsigned default '0',
--  md int(10) unsigned NOT NULL default '0',
  md int(10) unsigned default '0',
  INDEX (target_id),
  INDEX (coord_id),
--  FOREIGN KEY (target_id) REFERENCES Forma(ID) ON DELETE  CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (target_id) REFERENCES Path(target_id) ON DELETE  CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (coord_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


