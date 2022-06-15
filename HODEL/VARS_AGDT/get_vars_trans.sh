#Riportare nelle corrispondenti variabili del file TT.pm

#Congiunzioni
mysql -uroot -p hodel_test -s -e "SELECT DISTINCT concat('\'',conj,'\'',' => ','\'',str_trans,'\',') v FROM VerbArgument INNER JOIN forme_lemmi ON(conj=str_greek) ORDER BY conj ASC;" > Conjs_trans.AGDT.txt

#Preposizioni
mysql -uroot -p hodel_test -s -e "SELECT DISTINCT concat('\'',prep,'\'',' => ','\'',str_trans,'\',') v FROM VerbArgument INNER JOIN forme_lemmi ON(prep=str_greek) ORDER BY prep ASC;" > Preps_trans.AGDT.txt
