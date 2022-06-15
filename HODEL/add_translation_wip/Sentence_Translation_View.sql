-- vista trduzioni frasi

CREATE OR REPLACE VIEW Sentence_Translation_View AS 
SELECT CASE document_id 
            WHEN "urn:cts:greekLit:tlg0012.tlg001.perseus-grc1" THEN _utf8"ILIAD" 
            WHEN "urn:cts:greekLit:tlg0012.tlg002.perseus-grc1" THEN _utf8"ODYSSEY" 
       END poem, subdoc, sentence_text  
FROM Sentence s 
INNER JOIN Sentence_Translation t ON s.id=t.sentence_id;
