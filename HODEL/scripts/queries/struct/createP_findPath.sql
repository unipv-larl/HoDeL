DELIMITER $$

DROP PROCEDURE IF EXISTS findPath $$
CREATE PROCEDURE findPath (
RootTN VARCHAR(50), TargetTN VARCHAR(50), IntTN VARCHAR(50), PathTN VARCHAR(50)
)
BEGIN
DECLARE nonCompleti INT DEFAULT 0;

-- inizializza tabelle di lavoro secondo input
CALL initFindPath( RootTN, TargetTN, IntTN );

-- inizializza percorsi partendo dai nodi _Target
INSERT INTO _nuoviNodi
SELECT parent_id, Tree.forma_id AS target_id, parent_id, 1
FROM Tree INNER JOIN _Target ON Tree.forma_id=_Target.ID; 

-- itera il controllo dei percorsi 
REPEAT 

-- TRUNCATE _nuoviNodi;

   INSERT INTO _Path
   SELECT _nuoviNodi.*
   FROM _nuoviNodi, _Root
   WHERE _nuoviNodi.root_id = _Root.ID;

   -- elimina i _Path che non congiungono _Target con Nodi non permessi 
   DELETE FROM _nuoviNodi 
   USING  _nuoviNodi LEFT JOIN _InPath
   ON _nuoviNodi.root_id = _InPath.ID
   WHERE _InPath.ID IS NULL;


   SELECT COUNT(*) INTO nonCompleti FROM _nuoviNodi;
    
   IF nonCompleti > 0 THEN

      -- aggiorna profondità dei nodi
      UPDATE _nuoviNodi INNER JOIN Tree ON ( _nuoviNodi.root_id = Tree.forma_id)
      SET _nuoviNodi.depth=_nuoviNodi.depth+1, _nuoviNodi.root_id=Tree.parent_id; 

      -- procedi nel percorso
      INSERT INTO _nuoviNodi
      SELECT Tree.parent_id, target_id, Tree.parent_id, 1
      FROM _nuoviNodi, Tree
      WHERE depth=2 AND Tree.forma_id=_nuoviNodi.parent_id;
   
   END IF;

UNTIL nonCompleti = 0 END REPEAT;

-- elimina tabelle di lavoro e salva una copia dei _Path
CALL finFindPath(PathTN);

END$$

DELIMITER ;
