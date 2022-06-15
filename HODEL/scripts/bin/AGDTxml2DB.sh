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
xsltproc -o $FILEOUT $BINDIR/AGDTxml2csv.xsl $FILEIN
$DBA --local-infile < $QD/loadData.AGDT.sql
rm -f $FILEOUT

