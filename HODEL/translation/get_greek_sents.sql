       SELECT subdoc, GROUP_CONCAT(forma SEPARATOR ' ') AS greek_sent 
       FROM Forma 
            INNER JOIN (
                               SELECT  * 
                               FROM Sentence 
                               WHERE document_id="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1" 
                               AND SUBSTRING_INDEX(subdoc,'.',1)=1
                        ) B1 
            ON (frase=B1.id) 
       GROUP BY id_AGDT; 
