-- paths 
SELECT Verbo, Arg AS Argomento, CONCAT(pp,Arg_p) AS Percorso
FROM
( 
SELECT CONCAT('(',v.rank,')',v.forma) As Verbo, 
        CONCAT('(',t.rank,')',t.forma) As Arg , 
        CONCAT('-',t.afun,'-','(',t.rank,')',t.forma) As Arg_p , 
        GROUP_CONCAT( IF(depth>1,
                      CONCAT('-',p.afun,'-','(',p.rank,')',p.forma),
                      CONCAT('(',p.rank,')',p.forma)
                     ) ORDER BY depth ASC SEPARATOR '' ) As pp 
FROM Path 
     INNER JOIN Forma v ON root_id=v.ID 
     INNER JOIN Forma t ON target_id=t.ID 
     INNER JOIN Forma p ON parent_id=p.ID      
GROUP BY root_id,target_id
) TT;

