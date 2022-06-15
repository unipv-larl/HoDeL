# estrae lista delle preposizioni e delle congiunzioni
mysql -uroot -p itvalexdb -e "select distinct concat('\'',conj,'\',') from VerbArgument order by conj" > conjs.txt
mysql -uroot -p itvalexdb -e "select distinct concat('\'',prep,'\',') from VerbArgument order by prep" > preps.txt

