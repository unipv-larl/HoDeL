#!/bin/bash

source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "(Re)Builds Fillers (...) for all paths (...) in <database name>" 
   echo "Reads data from tables Path, RootCoordIndex, Summa, TargetCoord." 
   echo "Results will be stored table TreeView." 
   echo "WARNING : all data in <database name> tables Tfillers_scxx" 
   echo "USAGE   : sh $(basename $0) <database name>" 
   echo 
   exit
fi

DATABASE=$1
DBA="$MY $DATABASE"

$DBA < $QD/cleanFillers.sql

# ricerca percosi in base alle viste di ingresso
$DBA < $QD/fillers_scc1.sql
$DBA < $QD/fillers_scc2.sql
$DBA < $QD/fillers_scc3.sql
$DBA < $QD/fillers_scc4.sql
$DBA < $QD/fillers_scf1.sql
$DBA < $QD/fillers_scf2.sql

