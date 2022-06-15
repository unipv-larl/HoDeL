CREATE VIEW `Verbo` AS
SELECT *
FROM Forma
WHERE Forma.pos="2" Or Forma.pos=3;
