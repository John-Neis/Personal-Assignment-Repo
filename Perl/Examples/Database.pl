#!/usr/bin/perl

use DBI;

#$dataSource = "dbi:mysql:namesdb";

$dbh = DBI->connect("dbi:mysql:namesdb:localhost", "root", "pass260word");
if(!$dbh) {
	print "Unable to connect to the database.\n\n";
	exit;
}

my $sth = $dbh->prepare("SELECT * FROM tblnames;");
$sth->execute();

$count = 1;
print "NameID|-------|FirstName|----|LastName|-----|City|---------|State\n";
while($hashRef = $sth->fetchrow_hashref) {
	#%hash = %$hashRef;
	
	printf "%-15s%-15s%-15s%-15s%-2s\n", $hashRef->{"NameID"}, $hashRef->{"FirstName"}, $hashRef->{"LastName"}, $hashRef->{"City"}, $hashRef->{"State"};
}