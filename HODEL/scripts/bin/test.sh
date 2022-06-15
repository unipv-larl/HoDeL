#!/bin/bash

source ./db.config

sh $BINDIR/doall.sh $TESTDB $TESTCSTS
mysql -uroot $TESTDB -e "select frase, forma, scc1, scc2 , scc3 , scc4 , scf1 , scf2  from TreeView t, Forma f where t.root_id=f.ID Order by frase, rank" > $TESTOUT.txt
