# get all distinct strings

## correzione get_hodel_string: alcune forme hanno posAGDT = '-'

MYSQL_CMD="mysql -uroot -phodel_db_PaSsWoRd hodel_test "

query="SELECT DISTINCT forma COLLATE utf8_bin AS str \
       FROM Forma \
       UNION \
       SELECT DISTINCT lemma AS str \
       FROM Forma"

# check count
#$MYSQL_CMD -e "SELECT COUNT(DISTINCT str COLLATE utf8_bin) FROM ($query) t"
#$MYSQL_CMD -e "SELECT COUNT(str) FROM ($query) t"

#estrai lista_forme_lemmi
#$MYSQL_CMD -s -e "SELECT str FROM ($query) t" > lista_forme_lemmi_all.txt

#LISTA DEI CARATTERI. nb:grafem
#perl -C -ne'print grep {!$a{$_}++} /\X/g' lista_forme_lemmi_all.txt | grep -oP "\X" > lista_caratteri_all.txt


########### CONTROLLA che non ci siano caratteri non compresi in lista_caratteri.txt

#queryCreateMap="DROP TABLE IF EXISTS trans_map; \
       #CREATE TABLE trans_map ( \
         #ID int(10) unsigned NOT NULL AUTO_INCREMENT,\
         #greek char(5) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,\
         #trans char(5) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',\
         #PRIMARY KEY (ID)\
      #)"

#$MYSQL_CMD  -e "$queryCreateMap"
##$MYSQL_CMD --local-infile -e "LOAD DATA LOCAL INFILE 'lista_caratteri.txt' INTO TABLE trans_map(greek)"
#$MYSQL_CMD --local-infile -e "LOAD DATA LOCAL INFILE 'lista_caratteri_traslitterazione.txt' \
                              #INTO TABLE trans_map(greek,trans)"

#lista ordinata per lunghezza caratteri greci
queryOrder="SELECT greek, trans FROM trans_map ORDER BY CHAR_LENGTH(greek) DESC"
$MYSQL_CMD -s -e "$queryOrder" > lista_caratteri_traslitterazione.sorted.txt


#uso php per la sostituzione: vedi files
php sostituisci_caratteri.php

##merge greek-trans
paste -d$'\t'  lista_forme_lemmi_all.txt lista_forme_lemmi_all.trans.txt > lista_forme_lemmi_all.greek_trans.txt

queryCreateFormeLemmi="DROP TABLE IF EXISTS forme_lemmi; \
       CREATE TABLE forme_lemmi ( \
         ID int(10) unsigned NOT NULL AUTO_INCREMENT,\
         str_greek char(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,\
         str_trans char(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,\
         PRIMARY KEY (ID)\
      )"
$MYSQL_CMD  -e "$queryCreateFormeLemmi"
$MYSQL_CMD --local-infile -e "LOAD DATA LOCAL INFILE 'lista_forme_lemmi_all.greek_trans.txt' \
                              INTO TABLE forme_lemmi(str_greek,str_trans)"

$MYSQL_CMD  -e "ALTER TABLE forme_lemmi ADD INDEX (str_greek)"
