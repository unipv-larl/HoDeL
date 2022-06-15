#!/bin/bash

source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "(Re)Builds paths from Verbs to Sb[_Co] Obj[_Co] (...) in database <database name>:" 
   echo "Results will be stored tables Path, RootCoordIndex, Summa, TargetCoord" 
   echo "WARNING : all data in <database name> tables Path, RootCoordIndex, Summa, TargetCoord will be lost" 
   echo "USAGE   : sh $(basename $0) <database name>" 
   echo 
   exit
fi

DATABASE=$1

FILECORR=$2

DBA="$MY $DATABASE"

# ricerca percosi in base alle viste di ingresso
$DBA < $QD/doFindPaths.sql
$DBA < $QD/doFindIndiPath.sql
#applica correzioni manuali!!!!!!!
$DBA --local-infile -e "
CREATE TEMPORARY TABLE t ( s char(100),  vrank int(11), arank int(11) );
LOAD DATA LOCAL INFILE '$FILECORR' INTO TABLE t IGNORE 1 LINES;
DELETE Path.*
FROM Path, Forma v, Forma a, t
WHERE Path.root_id = v.ID AND Path.target_id = a.ID 
      AND v.frase = t.s AND v.rank = t.vrank AND a.rank = t.arank;
"

$DBA < $QD/getCoordsPerRoot.sql
$DBA < $QD/getMinCoordsPerTatget.sql

