#!/bin/bash

source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "(Re)Builds Labels (...) for all paths (...) in <database name>" 
   echo "Reads data from tables Path, RootCoordIndex, Summa, TargetCoord. Results will be stored table TreeView." 
   echo "WARNING : all data in <database name> table TreeView will be lost" 
   echo "USAGE   : sh $(basename $0) <database name>" 
   echo 
   exit
fi

DATABASE=$1
DBA="$MY $DATABASE"

$DBA < $QD/initTreeView.sql

# ricerca percosi in base alle viste di ingresso
$DBA < $QD/SC_1.sql
$DBA < $QD/SC_2.sql
$DBA < $QD/SC_3.sql
$DBA < $QD/SC_4.sql

