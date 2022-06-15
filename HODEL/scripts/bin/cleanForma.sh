#!/bin/bash

source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "Deletes all data in table Forma of database <database name>:" 
   echo "all table should be cleaned by foreign key delete cascade" 
   echo "USAGE   : sh $(basename $0) <database name>" 
   echo 
   exit
fi



DATABASE=$1
DBA="$MY $DATABASE"

# creazione tabelle di struttura
$DBA -e "truncate Forma"

