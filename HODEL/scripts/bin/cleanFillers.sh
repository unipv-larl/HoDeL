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

# creazione tabelle di struttura
$DBA -e "truncate Tfillers_scc1"
$DBA -e "truncate Tfillers_scc2"
$DBA -e "truncate Tfillers_scc3"
$DBA -e "truncate Tfillers_scc4"
$DBA -e "truncate Tfillers_scf1"
$DBA -e "truncate Tfillers_scf2"

