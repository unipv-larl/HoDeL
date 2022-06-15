#!/bin/bash

source ./db.config

testQuery="select new.frase, new.rank from (select frase, rank, scc1, scc2 , scc3 , scc4 , scf1 , scf2  from TreeView t, Forma f where t.root_id=f.ID Order by frase, rank) AS new natural left join (select frase, rank, scc1, scc2 , scc3 , scc4 , scf1 , scf2  from ITTB_test.TreeView t, ITTB_test.Forma f where t.root_id=f.ID Order by frase, rank)  as old where old.frase is null"

mysql -uroot $TESTDB -B -e "$testQuery" > diff.$TESTOUT.txt

