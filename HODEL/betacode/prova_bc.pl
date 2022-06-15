use utf8;

use Encode::BetaCode qw(beta_decode beta_encode);
#use Encode;
use DBI;

# αἶψ̓
# μῆνιν
my $language='greek';
my $text="%h\\%";
my $unicode_text = beta_decode($language, $text);

utf8::decode($unicode_text);

print "$text\n";

$db ="hodel_test";
$user = "root"; 
$pass = "hodel_db_PaSsWoRd";
$host="localhost";
 
## SQL query
$query = "SELECT forma FROM Forma WHERE forma LIKE '$unicode_text' COLLATE utf8_bin";

print "QUERY($query)\n";
 
$dbh = DBI->connect("DBI:mysql:$db:$host", $user, $pass, {mysql_enable_utf8 => 1});
$sqlQuery  = $dbh->prepare($query)
or die "Can't prepare $query: $dbh->errstr\n";
 
$rv = $sqlQuery->execute
or die "can't execute the query: $sqlQuery->errstr \n";
 
print "********** My Perl DBI Test ***************\n";
print "Here is a list of tables in the MySQL database $db.";
while (@row= $sqlQuery->fetchrow_array()) {
my $tables = $row[0];
print "$tables\n";
}

 
1;

