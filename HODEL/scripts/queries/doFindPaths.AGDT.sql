-- Target1 InPath1 Coordinati
-- Target2 InPath2 Non-Coordinati
-- cerca percorsi 
CALL findPath( 'Verbo', 'Target1', 'InPath1', 'Path1' );
CALL findPath( 'Verbo', 'Target2', 'InPath2', 'Path2' );

-- unisci i percorsi dei due insiemi
-- PAOLO: TRUNCATE da errore
-- TRUNCATE Path; 
DELETE FROM Path;
ALTER TABLE Path AUTO_INCREMENT = 1;


INSERT INTO Path
( SELECT * FROM Path1 )
UNION ALL
( SELECT * FROM Path2 );

DROP TABLE Path1;
DROP TABLE Path2;

