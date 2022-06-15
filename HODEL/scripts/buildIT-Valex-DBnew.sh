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

#temp :
$DBA < createT_Sentence.sql
$DBA < createF_case.sql
$DBA < createF_case_1.sql
#$DBA < createP_verbsArgsOverlap.sql
# decodifica modo
$DBA < createF_mode.sql

$DBA < argsCategories.sql
#$DBA < argsOrderCategory.sql
# solo overlap col verbo
$DBA < argsOrderCategoryNew.sql
$DBA < createT_VerbArgument.sql
#
#modifica modo/caso
$DBA < setModeCase.sql
#inserisci preposizioni in VerbArguments
$DBA < setPrep.sql
#inserisci congiunzioni in VerbArguments
$DBA < setConj.sql

$DBA < createF_diatesi.sql
$DBA < createT_DiatesiCat.sql

$DBA < dropSupportTables.sql
$DBA < alterPath.sql

