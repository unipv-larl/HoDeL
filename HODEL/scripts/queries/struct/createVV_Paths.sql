-- targets to root links
CREATE OR REPLACE VIEW TargetRoot AS
SELECT target_id, root_id 
FROM Path 
WHERE depth=1;

-- nodi 'coord' presenti negli alberi
CREATE OR REPLACE VIEW RootCoord AS
SELECT DISTINCT root_id, p.parent_id  AS coord_id
FROM Path AS p, Forma as f
WHERE p.parent_id=f.ID AND p.depth>1 AND f.afun='Coord'
ORDER BY root_id;

