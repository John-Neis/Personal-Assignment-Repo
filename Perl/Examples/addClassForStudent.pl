#!/usr/bin/perl

use DBI;

sub getTableID
{
   my $sql = shift;
   my $sth = $dbh->prepare($sql);
   $sth->execute();
   if ($arrayRef = $sth->fetchrow_arrayref) {
      $ID = $arrayRef->[0];
      return $ID;
   }
   else {
      return -1;
   }
}

$dataSource = "DBI:mysql:namesdb:localhost";
$dbh = DBI->connect ($dataSource, "root", "pass260word");
#$dbh = DBI->connect ($dataSource, "root", "pass260word", {PrintError => 0});
#open(STDERR, ">errors.txt");


if (!$dbh) {
   print "Unable to connect to the database\n\n";
   exit;
}

print "Enter student's first name: ";
chomp ($first = <STDIN>);
$first =~ s/\'/\\'/;
#$first = 'Fred';

print "Enter student's last name: ";
chomp ($last = <STDIN>);
$last =~ s/\'/\\'/;
#$last = 'Olson';

print "Add what class for $student: ";
chomp ($classTaken = <STDIN>);

#$classTaken = '160';

$studentID = getTableID ("SELECT studentID FROM students where FirstName = '$first' AND LastName = '$last'");
if ($studentID == -1) {
   print "Invalid student - buhbye";
   exit;
}

$classID = getTableID ("SELECT classID FROM classes where classNumber = '$classTaken'");
if ($classID == -1) {
   print "Invalid class - buhbye";
   exit;
}
$sql = "INSERT into classestaken (studentID, classID) VALUES ($studentID, $classID);";
#$sql = "INSERT into classestake VALUES ($studentID, $classID)";

print "Student id $studentID\n";
print "Class id $classID\n";
$result = $dbh->do($sql);
if($result) {
	print "Record added\n";
} else {
	print "Unable to add record\n";
}

print "\n\n";
