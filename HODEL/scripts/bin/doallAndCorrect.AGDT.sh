#!/bin/bash
##### opera correzioni manuali sui path!!!!!!!!!!
source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "(Re)Builds database <database name> and loads data from Perseus xml-file <file name>" 
   echo "WARNING : all data in <database name> will be lost" 
   echo "USAGE   : sh $(basename $0) <database name> <file name>" 
   echo 
   exit
fi

DATABASE=$1
FILEIN=$2
FILECORR=$3

sh $BINDIR/buildDB.AGDT.sh $DATABASE
sh $BINDIR/AGDTxml2DB.sh $FILEIN $DATABASE
######sh $BINDIR/buildPaths.sh $DATABASE
sh $BINDIR/buildPathsAndCorrect.AGDT.sh $DATABASE $FILECORR
#sh $BINDIR/buildTreeLabels.sh $DATABASE
#sh $BINDIR/buildFillers.sh $DATABASE

