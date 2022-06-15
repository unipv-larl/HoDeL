
-- Esplicita diatesi delle Forme
CREATE OR REPLACE VIEW Diatesi AS
SELECT ID, 
   IF (modo IN('A', 'B', 'C', 'D', 'E', 'G', 'H'), 
      "A", 
      if (modo in ('J','K','L','M','N','O','P','Q'),
         if( lemma like '%r',
            "D", 
            "P"),
         NULL) 
    ) as diatesi,
   IF (modo IN('A', 'B', 'C', 'D', 'E', 'G', 'H'), 
      "A", 
      if (modo in ('J','K','L','M','N','O','P','Q'),
         if( lemma like '%r',
            "A", 
            "P"),
         NULL) 
   ) as diatesi_nondep
FROM Forma;

-- completa TreeView con informazioni sulla diatesi per scc4
-- 
-- CREATE OR REPLACE VIEW TreeViewD AS
-- SELECT tv.*, 
-- concat_ws( '_', d.diatesi_nondep, scc4 ) AS scc4_diat_nondep,
-- concat_ws( '_', d.diatesi, scc4 ) AS scc4_diat
-- FROM TreeView tv, Diatesi d
-- WHERE tv.root_id=d.ID

