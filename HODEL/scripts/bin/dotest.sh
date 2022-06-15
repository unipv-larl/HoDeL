#!/bin/bash

source ./db.config

testQuery="select frase, forma, scc1, scc2 , scc3 , scc4 , scf1 , scf2  from TreeView t, Forma f where t.root_id=f.ID Order by frase, rank"

mysql -uroot $TESTDB -B -e "$testQuery" > $TESTOUT.txt

mysql -uroot $TESTDB -B -e "$testQuery" | sed 's/\t/","/g;s/^/"/;s/$/"/;s/\n//g' >  $TESTOUT.csv

mysql -uroot -H $TESTDB -B -e "$testQuery" > $TESTOUT.html
