
ALTER TABLE RootCoordIndex ADD dummy INT(11);

SET @root = '';
SET @idx = 1;
INSERT INTO RootCoordIndex( root_id, coord_id, alias, dummy )
SELECT RootCoord.*,
@idx := if( @root = RootCoord.root_id, @idx + 1, 1) as alias,
@root := RootCoord.root_id as dummy
FROM
( SELECT root_id, COUNT(*) as numCoord FROM RootCoord GROUP BY root_id ) AS coordPerRoot,
RootCoord
WHERE coordPerRoot.numCoord > 1 AND RootCoord.root_id=coordPerRoot.root_id
ORDER BY RootCoord.root_id;

ALTER TABLE RootCoordIndex DROP dummy;

-- tabella riassuntiva : root_id, target_id, parent_id, alias   
-- DROP TABLE IF EXISTS Summa;
-- CREATE TABLE Summa 
INSERT INTO Summa
SELECT p.*, alias
FROM  Path p
LEFT JOIN RootCoordIndex AS ci ON( p.root_id = ci.root_id AND p.parent_id = ci.coord_id )
ORDER BY root_id, target_id, depth;

-- TODO eliminare tabella Summa...

