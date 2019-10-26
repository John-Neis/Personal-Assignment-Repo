#!/usr/bin/perl

use DBI;
$dataSource = "DBI:mysql:namesdb:localhost";
$dbh = DBI->connect ($dataSource, "root", "pass260word");

if (!$dbh) {
   print "Unable to connect to the database\n\n";
   exit;
}

print "Enter first name: ";
chomp ($first = <STDIN>);
while ($first eq '') {
   print "You really need to enter a first name.\n";
   chomp ($first = <STDIN>);
}
$first =~ s/\'/\\'/g;
print "Enter last name: ";
chomp ($last = <STDIN>);

print "Enter city: ";
chomp ($city = <STDIN>);

print "Enter state: ";
chomp ($state = <STDIN>);

#$sql = "INSERT INTO tblnames VALUES (undef, '$last', '$first', '$city', '$state')";
$sql = "INSERT INTO tblnames (FirstName, LastName, City, State) VALUES ('$first', '$last', '$city', '$state')";
$returnValue = $dbh->do($sql);
print "Return value $returnValue\n\n";
print "$sql\n\n";

