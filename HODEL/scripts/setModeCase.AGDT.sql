-- ricava caso o modo degli argomenti
CREATE TEMPORARY TABLE hasChildAuxV
SELECT DISTINCT parent_id
FROM Tree t, Forma c
WHERE t.forma_id = c.ID AND c.afun = 'AuxV';

UPDATE VerbArgument va,
(
SELECT va.arg_id,

/*
       IF ( a.pos = 3 OR 
            ( a.pos = 2 AND 
            ( a.modo <> 'O' AND ( (a.modo <> 'D' AND a.modo <> 'M') OR (t.parent_id IS NOT NULL) ) ) ), 1, 0 
          ) AS isClause,
        IF ( a.pos = 3 OR 
            ( a.pos = 2 AND 
            ( a.modo <> 'O' AND ( (a.modo <> 'D' AND a.modo <> 'M') OR (t.parent_id IS NOT NULL) ) ) ), 
            dcmode(a.modo), dccase(a.caso) 
          ) AS rCase
*/ 
/*
       IF ( a.pos = 3 OR 
            ( a.pos = 2 AND 
            ( a.modo <> 'O' AND ( (a.modo <> 'D' AND a.modo <> 'M') OR (t.parent_id IS NOT NULL) ) ) ), 1, 0 
          ) AS isClause,
*/
-- DA CONTROLLARE!!!!!!          
        IF ( (a.posAGDT = 'v' AND a.mood<>'p') OR 
            ( (a.posAGDT = 'v' AND a.mood = 'p' AND t.parent_id IS NOT NULL) ), 
            dcmode(a.mood), dccase(a.case) 
          ) AS rCase
         
FROM VerbArgument va JOIN Forma a ON ( va.arg_id = a.ID )
LEFT JOIN hasChildAuxV t ON ( t.parent_id = va.arg_id )
) t
SET va.rCase = t.rCase
WHERE va.arg_id = t.arg_id;
