#!/bin/bash

source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "Recursively loads data from csts-files of $DATADIR into database <master database name>." 
   echo "Uses database <slave database name> to process each csts-file." 
   echo "WARNING : all data in <master database name> and in <master database name> will be lost" 
   echo "USAGE   : sh $(basename $0) <master database name> <slave database name>" 
   echo 
   exit
fi

master=$1
slave=$2

c=`ls -1 $DATADIR/*/*.csts | wc -l`
ci=0

sh $BINDIR/buildDB.sh $master
sh $BINDIR/buildDB.sh $slave

for d in `ls $DATADIR`; do
if [ -d "$DATADIR/$d" ]
then
   for ((i=1;i<=1000;i+=1)); do
   if [ -f "$DATADIR/$d/$d.DATI.$i.l.csts" ]
   then
      curfile=$DATADIR/$d/$d.DATI.$i.l.csts
   else
      if  [ -f "$DATADIR/$d/$d.DATI.$i.csts" ] # cisono due file mal formati!!
      then
         curfile=$DATADIR/$d/$d.DATI.$i.l.csts
      else
         break
      fi
   fi

   ((ci++))
   echo "file $ci of $c: $curfile"
START=`date +%s`

#echo "carico file......." 
sh $BINDIR/CSTS2DB.sh $curfile $slave
#echo "calcolo path......"
sh $BINDIR/buildPaths.sh $slave
#echo "calcolo labels...."
sh $BINDIR/buildTreeLabels.sh $slave
sh $BINDIR/buildFillers.sh $slave
#echo "copio in master..."
sh $BINDIR/cpDB.sh $slave $master
#echo "pulisco slave....."
sh $BINDIR/cleanDB.sh $slave

END=`date +%s`

ELAPSEDTIME=`expr $END - $START`
echo "It took $ELAPSEDTIME seconds"


   done
fi
done

