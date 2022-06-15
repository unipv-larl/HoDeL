

SELECT poem_id, book_id, start, end, sent_start, sent_end
FROM Book_paras NATURAL JOIN
(
SELECT P.poem_id,P.book_id,P.start,
       MIN(sent_start) AS sent_start, MAX(sent_end) AS sent_end, SUM( CHAR_LENGTH(forma) ) AS para_l  
FROM Book_paras P
INNER JOIN ( 
       SELECT document_id AS poem_id, 
       CAST( SUBSTRING_INDEX(subdoc,'.',1)  AS UNSIGNED) AS book_id,
       CAST( SUBSTRING_INDEX( SUBSTRING_INDEX(subdoc,'-',1),'.',-1)  AS UNSIGNED) sent_start, 
       CAST( SUBSTRING_INDEX( SUBSTRING_INDEX(subdoc,'-',-1),'.',-1)  AS UNSIGNED)  sent_end,
       forma
       FROM Sentence 
       INNER JOIN Forma
            ON (frase=Sentence.id)
       WHERE posAGDT<>'u'
      ) G 
ON( P.poem_id=G.poem_id AND P.book_id=G.book_id AND sent_start>=start AND ( end IS NULL OR sent_end<=end ) )
GROUP BY P.poem_id,P.book_id,P.start
) GP
WHERE end IS NULL;
