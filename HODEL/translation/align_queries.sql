-- align

-- greek sents conttained in milestones segments
-- SELECT ms_start, ms_end, sent_start, sent_end, sent_id 
-- FROM Para_en_ms M 
-- INNER JOIN Para_gr_sents S 
-- ON( S.para_start=M.para_start AND sent_start>=ms_start AND sent_end<=ms_end);


-- SELECT para_start,
       -- SUBSTR(sent_gr FROM CHAR_LENGTH(sent_gr) ) AS punct, 
       -- COUNT(*) AS no_punct 
-- FROM Para_gr_sents 
-- GROUP  BY para_start, punct;


-- SELECT  * --  para_start, no_fs+no_c AS en_c, no_HP AS  gr_c
-- FROM
-- (
-- SELECT para_start,
       -- SUM( CHAR_LENGTH( sent_en ) - CHAR_LENGTH( REPLACE( sent_en, ".", "") )) AS no_fs,
       -- SUM( CHAR_LENGTH( sent_en ) - CHAR_LENGTH( REPLACE( sent_en, ":", "") )) AS no_c,
       -- SUM( CHAR_LENGTH( sent_en ) - CHAR_LENGTH( REPLACE( sent_en, ";", "") )) AS no_sc,
       -- SUM( CHAR_LENGTH( sent_en ) - CHAR_LENGTH( REPLACE( sent_en, "?", "") )) AS no_qm,
       -- COUNT(*) AS no_sents
-- FROM Para_en_sents
-- GROUP BY para_start
-- ) EN
-- INNER JOIN
-- (
-- SELECT para_start,
       -- SUM( CHAR_LENGTH( sent_gr ) - CHAR_LENGTH( REPLACE( sent_gr, ".", "") )) AS no_LP,
       -- SUM( CHAR_LENGTH( sent_gr ) - CHAR_LENGTH( REPLACE( sent_gr, "·", "") )) AS no_HP,
       -- SUM( CHAR_LENGTH( sent_gr ) - CHAR_LENGTH( REPLACE( sent_gr, ";", "") )) AS no_SC,
       -- COUNT(*) AS no_sents
-- FROM Para_gr_sents
-- GROUP BY para_start
-- ) GR
-- USING(para_start);


-- milestones contenenti punteggiatura forte
SELECT para_start,ms_start,ms_end,
       SUM( CHAR_LENGTH( ms_en ) - CHAR_LENGTH( REPLACE( ms_en, ".", "") )) AS no_fs,
       SUM( CHAR_LENGTH( ms_en ) - CHAR_LENGTH( REPLACE( ms_en, ":", "") )) AS no_c,
       SUM( CHAR_LENGTH( ms_en ) - CHAR_LENGTH( REPLACE( ms_en, ";", "") )) AS no_sc,
       SUM( CHAR_LENGTH( ms_en ) - CHAR_LENGTH( REPLACE( ms_en, "?", "") )) AS no_qm
FROM Para_en_ms
GROUP BY para_start, ms_start, ms_end
HAVING ( no_fs>0 OR no_c>0 OR no_qm>0 )
