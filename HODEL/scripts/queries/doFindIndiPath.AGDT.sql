-- Verbi con coordinazione 
CREATE OR REPLACE VIEW `VerboCoord` AS
SELECT *
FROM Forma
-- NOTA BENE!!! da controllare differenze IT - AGDT
-- WHERE ( Forma.pos="2" Or Forma.pos=3 ) 
WHERE ( Forma.posAGDT="v" ) 
AND ( afun LIKE "%_Co" Or afun Like "%_Ap");

-- Token Coordinanti 
CREATE OR REPLACE VIEW `CoordApos` AS
SELECT *
FROM Forma
WHERE ( afun LIKE "Coord%" Or afun Like "Apos%");

-- Target1 InPath1 Coordinati
-- Target2 InPath2 Non-Coordinati

-- TODO spostare le viste e le tabelle nelle query di struttura

-- cerca percorsi 
CALL findPath( 'CoordApos', 'VerboCoord', 'InPath1', 'PathVC' );
CALL findPath( 'CoordApos', 'Target2', 'InPath2', 'PathArgs' );

-- tabella dei path indiretti
drop table if exists IndiPath;
create table IndiPath Like PathVC; 

INSERT INTO IndiPath
  (SELECT a.* 
  FROM PathArgs a, PathVC vc 
  WHERE a.root_id=vc.root_id)
  UNION 
  (SELECT vc.* 
  FROM PathArgs a, PathVC vc 
  WHERE a.root_id=vc.root_id);

-- controllo: vista dei sotto-alberi di persorsi indiretti
drop table if exists IndiPathV;
create table IndiPathV 
select root_id, 
group_concat( 
              if( l is null, if(root_id<>ID,afun, concat('*',afun, '*') ), concat('(',l,')', afun )) order by rank
) as l 
from (
       (select root_id, target_id, group_concat(afun order by depth) as l 
        from IndiPath p left join   Forma f  
        on( p.parent_id=f.ID and depth>1) 
        group by root_id, target_id
       ) union 
       (select distinct root_id, root_id, NULL from IndiPath )
     ) pl, Forma f 
where pl.target_id=f.ID 
group by root_id;

-- tabella dei path indiretti
drop table if exists Innesti;
create table Innesti Like PathVC; 

-- essegna root fittizia ai percorsi da innestare
INSERT INTO Innesti
  SELECT vc.target_id, a.target_id, if(a.depth>1, a.parent_id, vc.target_id), a.depth 
  FROM PathArgs a, PathVC vc 
  WHERE a.root_id=vc.root_id;

-- innesta...
Insert into Path select * From Innesti;


