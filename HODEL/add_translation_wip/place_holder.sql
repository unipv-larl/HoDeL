-- metti place-holders per traduzioni

REPLACE INTO Sentence_Translation 
SELECT id, CONCAT( "PLACE HOLDER for: ",document_id," - ",subdoc) 
FROM Sentence;
