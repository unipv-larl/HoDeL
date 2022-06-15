-- preposizioni degli argomenti
-- 
SELECT v.lemma AS verb, a.lemma AS arg
FROM
(
   SELECT root_id, arg_id, count(*) AS num
   FROM
   ( 
      SELECT p.root_id, p.target_id as arg_id, f.lemma as prep
      FROM Path p, Forma f 
      WHERE p.parent_id = f.ID AND f.afun = 'AuxC'
   ) t
   GROUP BY arg_id, root_id
   HAVING num > 1
) mC, Forma v, Forma a
WHERE mC.root_id=v.ID AND mC.arg_id=a.ID

