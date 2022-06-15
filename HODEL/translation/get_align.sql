SELECT ID, `start`, `end`, Sentence_greek.sent AS greek, Sentence_eng.sent AS eng
FROM Sentence_greek 
LEFT JOIN Sentence_eng
USING(ID)
ORDER BY ID
LIMIT 10;

