truncate TreeView;

INSERT INTO TreeView(root_id)
SELECT DISTINCT root_id FROM TargetRoot; 

