#!/bin/bash

source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "(Re)Builds database <database name>" 
   echo "WARNING : all data in <database name> will be lost" 
   echo "USAGE   : sh $(basename $0) <database name>" 
   echo 
   exit
fi

DATABASE=$1
DBA="$MY $DATABASE"

$MY -e "DROP DATABASE IF EXISTS $DATABASE"
## ASSICURO CODIFICA UTF8
#$MY -e "CREATE DATABASE $DATABASE"
$MY -e "CREATE DATABASE $DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci";

# creazione tabelle di struttura
$DBA < $QD/struct/createT_Forma.AGDT.sql
$DBA < $QD/struct/createT_Tree.sql

# stored procedures per la ricerca dei percorsi
$DBA < $QD/struct/createP_initFindPath.sql
$DBA < $QD/struct/createP_findPath.sql
$DBA < $QD/struct/createP_finFindPath.sql

# viste di ingresso
##AGDT
#$DBA < $QD/struct/createV_Verbo.sql
$DBA < $QD/struct/createV_Verbo.AGDT.sql
##
$DBA < $QD/struct/createVV_inputRules.sql

# tabelle percorsi:
$DBA < $QD/struct/createTT_Paths.sql 

# viste percorsi:
$DBA < $QD/struct/createVV_Paths.sql 

# crea tabelle etichette:
#$DBA < $QD/struct/createT_TreeView.sql

#$DBA < $QD/struct/createV_Diatesi.sql

#$DBA < $QD/struct/createTT_Fillers.sql
#$DBA < $QD/struct/createVV_Fillers.sql

#$DBA < $QD/struct/createV_TreeView_conusintr.sql
#$DBA < $QD/struct/createVV_Fillers_usintr.sql
#$DBA < $QD/struct/createVV_lessico_valenza.sql
#$DBA < $QD/struct/createVV_freq.sql


