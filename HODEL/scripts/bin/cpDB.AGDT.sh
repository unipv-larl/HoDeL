#!/bin/bash

source ./db.config

if [ "$#" -eq 0 ]
then
   echo 
   echo "Puts all data from <source database name> into <dest database name>" 
   echo "USAGE   : sh $(basename $0) <source database name> <dest database name>" 
   echo 
   exit
fi

SRCDB=$1
DESTDB=$2

FFIELDS="forma,lemma,posAGDT,pers,num,tense,mood,voice,gend,\`case\`,degree,afun,rank,gov,frase,cite,subdoc,id_AGDT,document_id"

# inserisci forme nel DB Dest 
$MY -e "INSERT INTO $DESTDB.Forma( $FFIELDS ) 
SELECT $FFIELDS FROM $SRCDB.Forma"

## aggiorna ID delle forme nel DB Source: aggiornamento a cascata 
$MY -e "UPDATE $DESTDB.Forma, $SRCDB.Forma 
SET $SRCDB.Forma.ID=$DESTDB.Forma.ID
WHERE $SRCDB.Forma.frase=$DESTDB.Forma.frase AND $SRCDB.Forma.rank=$DESTDB.Forma.rank"

## aggiorna Tree
$MY -e "INSERT INTO $DESTDB.Tree SELECT * FROM $SRCDB.Tree"

## aggiorna Path
$MY -e "INSERT INTO $DESTDB.Path SELECT * FROM $SRCDB.Path"

## aggiorna TreeView
#$MY -e "INSERT INTO $DESTDB.TreeView SELECT * FROM $SRCDB.TreeView"

## aggiorna RootCoordIndex
$MY -e "INSERT INTO $DESTDB.RootCoordIndex SELECT * FROM $SRCDB.RootCoordIndex"

## aggiorna Summa
$MY -e "INSERT INTO $DESTDB.Summa SELECT * FROM $SRCDB.Summa"

## aggiorna TargetCoord
$MY -e "INSERT INTO $DESTDB.TargetCoord SELECT * FROM $SRCDB.TargetCoord"

# aggiorna fillers
#$MY -e "INSERT INTO $DESTDB.Tfillers_scc1 SELECT * FROM $SRCDB.Tfillers_scc1"
#$MY -e "INSERT INTO $DESTDB.Tfillers_scc2 SELECT * FROM $SRCDB.Tfillers_scc2"
#$MY -e "INSERT INTO $DESTDB.Tfillers_scc3 SELECT * FROM $SRCDB.Tfillers_scc3"
#$MY -e "INSERT INTO $DESTDB.Tfillers_scc4 SELECT * FROM $SRCDB.Tfillers_scc4"
#$MY -e "INSERT INTO $DESTDB.Tfillers_scf1 SELECT * FROM $SRCDB.Tfillers_scf1"
#$MY -e "INSERT INTO $DESTDB.Tfillers_scf2 SELECT * FROM $SRCDB.Tfillers_scf2"


