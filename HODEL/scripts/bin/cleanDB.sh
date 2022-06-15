#!/bin/bash

source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "Deletes all data from database <database name>" 
   echo "USAGE   : sh $(basename $0) <database name>" 
   echo 
   exit
fi


DATABASE=$1
DBA="$MY $DATABASE"

# eliminazione di tutte le tabelle.
# al momento sono superflue perchè 
# le tabelle sono ricreate...
$DBA -e "DROP TABLE IF EXISTS Tfillers_scc1"
$DBA -e "DROP TABLE IF EXISTS Tfillers_scc2"
$DBA -e "DROP TABLE IF EXISTS Tfillers_scc3"
$DBA -e "DROP TABLE IF EXISTS Tfillers_scc4"
$DBA -e "DROP TABLE IF EXISTS Tfillers_scf1"
$DBA -e "DROP TABLE IF EXISTS Tfillers_scf2"
$DBA -e "DROP TABLE IF EXISTS Path"
$DBA -e "DROP TABLE IF EXISTS RootCoordIndex"
$DBA -e "DROP TABLE IF EXISTS Summa"
$DBA -e "DROP TABLE IF EXISTS TargetCoord"
$DBA -e "DROP TABLE IF EXISTS Tree"
$DBA -e "DROP TABLE IF EXISTS TreeView"
$DBA -e "DROP TABLE IF EXISTS Forma"

$DBA < $QD/struct/createT_Forma.sql
$DBA < $QD/struct/createT_Tree.sql
$DBA < $QD/struct/createTT_Paths.sql 
$DBA < $QD/struct/createT_TreeView.sql
$DBA < $QD/struct/createTT_Fillers.sql

