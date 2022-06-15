
DROP TABLE IF EXISTS VerbArgument;
CREATE TABLE `VerbArgument` (
  `root_id` int(11) unsigned NOT NULL,
  `arg_id` int(11) unsigned NOT NULL,
  `coord_id` int(11) unsigned NOT NULL,
  `mn` int(10) unsigned NOT NULL,
  `mx` int(10) unsigned NOT NULL,
  `relation` char(10),
  `rCase` char(10),
--  `lemma` char(20),
  `lemma` char(30) NOT NULL COLLATE utf8_bin,  -- NOTA BENE
  KEY `root_id` (`root_id`),
  PRIMARY KEY (`root_id`, `arg_id`),
  FOREIGN KEY (root_id) REFERENCES Forma(ID) ON DELETE CASCADE  ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO VerbArgument(`root_id`, `coord_id`,`mn`, `mx`,`relation`, `arg_id`, `lemma`, `rCase` )
(SELECT va.root_id, va.trueTarget, va.mn, va.mx, va.lab, tc.target_id, ft.lemma, 
-- HODEL
--       IF(ft.pos = "2" Or ft.pos ="3", "CLAUSE", IFNULL( dccase(ft.caso), "CLAUSE" )) 
       IF(ft.posAGDT = "v", "CLAUSE", IFNULL( dccase(ft.case), "CLAUSE" )) 
-- HODEL       
 FROM VerbArg va 
     JOIN TargetCoord tc ON(va.trueTarget=tc.coord_id)  
     JOIN Forma ft ON( ft.ID=tc.target_id )
 WHERE va.lab <> 'V')
UNION 
(SELECT va.root_id, va.trueTarget, va.mn, va.mx, va.lab, tr.target_id, ft.lemma, 
-- HODEL
--       IF(ft.pos = "2" Or ft.pos ="3", "CLAUSE", IFNULL( dccase(ft.caso), "CLAUSE" )) 
       IF(ft.posAGDT = "v", "CLAUSE", IFNULL( dccase(ft.case), "CLAUSE" )) 
-- HODEL       
 FROM VerbArg va 
     JOIN TargetRoot tr ON(va.trueTarget=tr.target_id)  
     JOIN Forma ft ON( ft.ID=tr.target_id )
 WHERE va.lab <> 'V');

