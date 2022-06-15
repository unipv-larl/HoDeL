#Riportare nelle corrispondenti variabili del file TT.pm

#Congiunzioni
mysql -uroot -p hodel_test -s -e "SELECT DISTINCT concat('\'',conj,'\',') v FROM VerbArgument ORDER BY v ASC" > Conjs.AGDT.txt

#Preposizioni
mysql -uroot -p hodel_test -s -e "SELECT DISTINCT concat('\'',prep,'\',') v FROM VerbArgument ORDER BY v ASC" > Preps.AGDT.txt
