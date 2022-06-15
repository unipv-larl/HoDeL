# calculate stats
set -e

MYSQL_CMD="mysql -uroot -phodel_db_PaSsWoRd hodel_test "

queryStat_C="DROP TABLE IF EXISTS Book_stats; \
       CREATE TABLE Book_stats ( \
         poem_id VARCHAR(60) NOT NULL,\
         book_id int(10) unsigned NOT NULL,\
         eng_book_l int(10) unsigned NOT NULL DEFAULT 0,\
         greek_book_l int(10) unsigned NOT NULL DEFAULT 0,\
         PRIMARY KEY (poem_id,book_id)\
      )"

#echo "$queryStat_C"

$MYSQL_CMD  -e "$queryStat_C"

iliadID="urn:cts:greekLit:tlg0012.tlg001.perseus-grc1"
odysseyID="urn:cts:greekLit:tlg0012.tlg002.perseus-grc1"

#ENG
queryStat_I="INSERT INTO Book_stats(poem_id,book_id,eng_book_l) VALUES"

# ILIAD books length
iliadXML=Perseus_text_1999.01.0134.xml
echo "ILIAD"
for book in $(seq 1 24)
 do 
    book_length=$(xsltproc --param book $book prova_with_milestones.xsl $iliadXML |\
     tr -d [:digit:][:space:][:punct:] |\
     wc -m)
    echo -e "book:\t$book\tlength\t$book_length"
    $MYSQL_CMD  -e "$queryStat_I ('$iliadID',$book,$book_length);"
 done


# ODYSSEY books length
odysseyXML=Perseus_text_1999.01.0136.xml
echo "ODYSSEY"
for book in $(seq 1 24)
 do 
    book_length=$(xsltproc --param book $book prova_with_milestones.xsl $odysseyXML |\
     tr -d [:digit:][:space:][:punct:] |\
     wc -m)
    echo -e "book:\t$book\tlength\t$book_length"
    $MYSQL_CMD  -e "$queryStat_I ('$odysseyID',$book,$book_length);"
 done


#GREEK
queryPop_greek="\
UPDATE Book_stats \
NATURAL JOIN ( \
       SELECT document_id AS poem_id, CAST( SUBSTRING_INDEX(subdoc,'.',1)  AS UNSIGNED) AS book_id,\
        SUM( CHAR_LENGTH(forma) ) AS book_l \
       FROM Forma INNER JOIN Sentence \
            ON (frase=Sentence.id) \
       WHERE posAGDT<>'u' \
       GROUP BY document_id, book_id \
      ) G \
SET greek_book_l=book_l \
"
$MYSQL_CMD  -e "$queryPop_greek"

# RATIO
# SELECT poem_id, book_id, greek_book_l/eng_book_l AS ratio FROM Book_stats;

# PARAM
# SELECT poem_id, 
#        AVG(greek_book_l/eng_book_l) AS c,
#        STD(greek_book_l/eng_book_l) AS s, 
#        VARIANCE(greek_book_l/eng_book_l) AS s2 
# FROM Book_stats 
# GROUP BY poem_id;
