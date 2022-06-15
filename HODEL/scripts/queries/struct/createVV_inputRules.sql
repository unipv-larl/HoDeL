-- viste di ingresso: primo insieme
CREATE OR REPLACE View Target1 AS
SELECT * FROM Forma
WHERE afun LIKE 'Sb_%' OR afun LIKE 'Obj_%'  OR afun LIKE 'Pnom_%' OR afun LIKE 'OComp_%';

CREATE OR REPLACE View InPath1 AS
SELECT * FROM Forma
WHERE afun IN('AuxC','AuxP') OR afun LIKE 'Coord%' OR afun LIKE 'Apos%';


-- viste di ingresso: secondo insieme
CREATE OR REPLACE View Target2 AS
SELECT * FROM Forma
WHERE afun IN('Sb', 'Obj', 'Pnom', 'OComp');

CREATE OR REPLACE View InPath2 AS
SELECT * FROM Forma
WHERE afun IN('AuxC','AuxP');

-- TODO: dare dei nomi piu' significativi?

