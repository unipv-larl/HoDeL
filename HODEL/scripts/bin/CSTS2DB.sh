#!/bin/bash

source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "Loads data from csts-file <file name> into database <database name> and " 
   echo "USAGE   : sh $(basename $0) <file name> <database name>" 
   echo 
   exit
fi

FILEIN=$1
DATABASE=$2
FILEOUT=datafile.csv # see loadData.sql
DBA="$MY $DATABASE"

# creazione tabelle di struttura
perl $BINDIR/csts2csv.pl $FILEIN $FILEOUT
$DBA --local-infile < $QD/loadData.sql
rm -f $FILEOUT

