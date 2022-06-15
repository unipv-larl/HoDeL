
MYSQL_CMD="mysql -uroot -pPaShalom hodel_test "

querySents_eng="DROP TABLE IF EXISTS Sentence_eng; \
       CREATE TABLE Sentence_eng ( \
         ID int(10) unsigned NOT NULL AUTO_INCREMENT,\
         sent text NOT NULL,\
         PRIMARY KEY (ID)\
      )"

$MYSQL_CMD  -e "$querySents_eng"

xsltproc prova_with_milestones.xsl Perseus_text_1999.01.0134.xml > prova.txt
#python3 get_sents_2.py > prova_Iliad_1.txt
python3 get_sents_mod.py > prova_Iliad_1.txt
$MYSQL_CMD --local-infile -e "LOAD DATA LOCAL INFILE 'prova_Iliad_1.txt' INTO TABLE Sentence_eng(sent)"


querySents_greek="DROP TABLE IF EXISTS Sentence_greek; \
       CREATE TABLE Sentence_greek ( \
         ID int(10) unsigned NOT NULL AUTO_INCREMENT,\
         start int(10) unsigned NOT NULL,\
         end int(10) unsigned NOT NULL,\
         sent text NOT NULL,\
         PRIMARY KEY (ID)\
      )"

$MYSQL_CMD  -e "$querySents_greek"

queryPop_greek="\
INSERT INTO Sentence_greek( start, end, sent) \
SELECT SUBSTRING_INDEX( SUBSTRING_INDEX(subdoc,'-',1),'.',-1) start, \
       SUBSTRING_INDEX( SUBSTRING_INDEX(subdoc,'-',-1),'.',-1)  end, \
       greek_sent \
FROM ( \
       SELECT subdoc, id_AGDT, GROUP_CONCAT(forma SEPARATOR ' ') AS greek_sent \
       FROM Forma \
            INNER JOIN (\
                               SELECT  * \
                               FROM Sentence \
                               WHERE document_id='urn:cts:greekLit:tlg0012.tlg001.perseus-grc1'\
                               AND SUBSTRING_INDEX(subdoc,'.',1)=1\
                        ) B1 \
            ON (frase=B1.id) \
       GROUP BY id_AGDT \
      ) G \
"
$MYSQL_CMD  -e "$queryPop_greek"
