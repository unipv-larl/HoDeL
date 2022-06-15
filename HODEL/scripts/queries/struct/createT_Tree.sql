-- create dependency tree table

CREATE TABLE `Tree` (
  `forma_id` int(10) unsigned NOT NULL default '0',
  `parent_id` int(10) unsigned default '0',
  UNIQUE INDEX (forma_id),
  INDEX (parent_id),
  FOREIGN KEY (parent_id) REFERENCES Forma(ID) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (forma_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

