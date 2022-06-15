#!/bin/bash

# original file: buildIT-Valex-DBnew.sh

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

#temp :
##HODEL
#$DBA < $BD/createT_Sentence.sql
$DBA < $BD/createT_Sentence.AGDT.sql
##
$DBA < $BD/createF_case.AGDT.sql
$DBA < $BD/createF_case_1.AGDT.sql
#$DBA < createP_verbsArgsOverlap.sql
# decodifica modo
$DBA < $BD/createF_mode.AGDT.sql

$DBA < $BD/argsCategories.sql
#$DBA < argsOrderCategory.sql
# solo overlap col verbo
$DBA < $BD/argsOrderCategoryNew.sql
## HODEL
$DBA < $BD/createT_VerbArgument.AGDT.sql
##
## HODEL
## crea campi lemma per ordinamento ed indicizza
$DBA < $BD/alterT_VerbArgument.AGDT.sql
$DBA < $BD/alterT_Forma.AGDT.sql
##
#
#modifica modo/caso
## HODEL
$DBA < $BD/setModeCase.AGDT.sql
#inserisci preposizioni in VerbArguments
$DBA < $BD/setPrep.sql
#inserisci congiunzioni in VerbArguments
$DBA < $BD/setConj.sql

$DBA < $BD/createF_diatesi.AGDT.sql
$DBA < $BD/createT_DiatesiCat.AGDT.sql

$DBA < $BD/dropSupportTables.sql
$DBA < $BD/alterPath.sql

