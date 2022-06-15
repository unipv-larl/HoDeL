-- nodi 'coord' di minima profondità per ciascun target
-- DROP TABLE IF EXISTS TargetCoord;

-- CREATE TABLE TargetCoord
INSERT INTO TargetCoord
SELECT p.target_id, p.parent_id AS coord_id, minT.md
FROM
(
SELECT p.target_id, min(p.depth) AS md
FROM Path AS p, Forma as f
WHERE  p.parent_id=f.ID AND f.afun IN ('Coord', 'Apos')  AND p.depth>1
GROUP BY p.target_id
) minT, Path p
WHERE minT.target_id=p.target_id AND p.depth=minT.md;


DROP TABLE IF EXISTS MinRootCoord;

CREATE TABLE MinRootCoord
SELECT DISTINCT tr.root_id, mt.coord_id 
FROM TargetRoot AS tr, TargetCoord mt
WHERE tr.target_id = mt.target_id
ORDER BY tr.root_id;


-- crea tabella degli alias per ciascun 'coord' di minima profondità ambiguo
DROP TABLE IF EXISTS MinRootCoordIndex;

SET @root = '';
SET @idx = 1;
CREATE TABLE MinRootCoordIndex
SELECT MinRootCoord.root_id, MinRootCoord.coord_id,
@idx := if( @root = MinRootCoord.root_id, @idx + 1, 1) as aliasMin,
@root := MinRootCoord.root_id as dummy
FROM
( SELECT root_id, COUNT(*) as numCoord FROM MinRootCoord GROUP BY root_id ) AS coordPerRoot,
MinRootCoord
WHERE coordPerRoot.numCoord > 1 AND MinRootCoord.root_id=coordPerRoot.root_id
ORDER BY MinRootCoord.root_id;

ALTER TABLE MinRootCoordIndex DROP dummy;

--    
UPDATE TargetCoord tc LEFT JOIN MinRootCoordIndex mci ON tc.coord_id=mci.coord_id
SET md=aliasMin;

-- elimina tabelle di supporto:
DROP TABLE IF EXISTS MinRootCoordIndex;
DROP TABLE IF EXISTS MinRootCoord;

