#!/usr/bin/perl

# John Neis, ID: 8003486
# Program 5
# Description: Write a program which allows a user to
# interface with the given database.

use DBI;
use strict;

sub connectToDB {
	# Copy-paste code connecting to DB
	my $dataSource = "DBI:mysql:f19db:localhost";
	my $user = "root";
	my $pwd = "pass260word";

	my $handle = DBI->connect(
					$dataSource, 
					$user, 
					$pwd, 
					#{PrintError => 0}
				);
	if(!$handle) {
		print "Unable to connect to database.\n";
		exit;
	}
	return $handle;
}

sub showMenu {
	print "Please choose an action (1..5)\n";
	print "\t1. Add a book\n",
		  "\t2. Display all books\n",
		  "\t3. Search for a book\n",
		  "\t4. Check out a book\n",
		  "\t5. Check in a book\n",
		  "Choice: "
	;
	
	#Only take first digit found and then check it is in range
	my $input = <STDIN>;
	if($input =~ /(\d)/) {
		$input = $1;
	}
	while($input < 1 || $input > 5) {
		print "Choice out of range. Choose again: ";
		$input = <STDIN>;
		if($input =~ /(\d)/) {
			$input = $1;
		}
	}
	return $input;
}

sub printQuery {
	my $sth = shift;
	print ">  Title                         |  Author              |  Total copies  |  Available  <\n";
	while(my $hashRef = $sth->fetchrow_hashref) {
		printf ">  %-30.30s|  %-20.20s|  %-14s|  %-11s<\n",
				$hashRef->{'title'},
				$hashRef->{'author'},
				$hashRef->{'totalCopies'},
				$hashRef->{'copiesAvailable'}
		;
	}
}

my $dbh = connectToDB;
my ($sth, $sql);
my $continue = 'y';

while($continue eq 'y') {
	my $usrChoice = showMenu;
	print "\n";
	if($usrChoice == 1) {
	
		print "Enter the title of the book to add: ";
		chomp(my $title = <STDIN>);
		print "Enter the book's author: ";
		chomp(my $author = <STDIN>);
		print "Enter the number of copies to add: ";
		chomp(my $copies = <STDIN>);
		
		$sql = "INSERT INTO library (title, author, totalCopies, copiesAvailable) "
		. "VALUES ('$title', '$author', $copies, $copies);";
		my $result = $dbh->do($sql);
		if($result) {
			print "Added record to library.\n";
		} else {
			print "Unable to add record to library.\n";
		}
		
	} elsif($usrChoice == 2) {
		
		$sql = "SELECT * FROM library ORDER BY title;";
		$sth = $dbh->prepare($sql);
		$sth->execute();
		
		printQuery($sth);
		
	} elsif($usrChoice == 3) {
		
		print "Enter search criteria: ";
		chomp(my $criteria = <STDIN>);
		$sql = "SELECT * FROM library WHERE title LIKE '%$criteria%' OR author LIKE '%$criteria%' ORDER BY title;";
		$sth = $dbh->prepare($sql);
		$sth->execute();
		
		printQuery($sth);
		
	} elsif($usrChoice == 4) {
	
		$sql = "SELECT * FROM library ORDER BY title;";
		$sth = $dbh->prepare($sql);
		$sth->execute();
		my $i = 0;
		my @tblArray;
		# Use an array to keep track of indexes for records returned
		print ">  Index  |  Title          |  Author         |  Total copies  |  Available  <\n";
		while(my $hashRef = $sth->fetchrow_hashref) {
			printf ">  %-7d|%-17.17s|%-17.17s|  %-14s|  %-11s<\n",
					$i,
					$hashRef->{'title'},
					$hashRef->{'author'},
					$hashRef->{'totalCopies'},
					$hashRef->{'copiesAvailable'}
			;
			$tblArray[$i] = $hashRef;
			$i-=-1;
		}
		print "Enter index of book you want to check out: ";
		chomp(my $checkOutBook = <STDIN>);
		
		if($tblArray[$checkOutBook]->{'copiesAvailable'} >= 1) {
			my $cpsAvail = $tblArray[$checkOutBook]->{'copiesAvailable'} - 1;
			my $updateID = $tblArray[$checkOutBook]->{'libraryID'};
		
			$sql = "UPDATE library SET copiesAvailable = $cpsAvail WHERE (libraryID = $updateID);";
			my $result = $dbh->do($sql);
			my $title = $tblArray[$checkOutBook]->{'title'};
		
			if($result) {
				print "Successfully checked out $title\n";
			} else {
				print "Unable to check out $title\n";
			}
		} else {
			print "There are no more copies of this book left.\n";
		}
		
		
	} elsif($usrChoice == 5) {
		
		# Almost identical to checking out. Instead of decrementing
		# copiesAvailable, increment. Instead of checking copiesAvailable
		# is more than 0, check that it's less than totalCopies
		$sql = "SELECT * FROM library ORDER BY title;";
		$sth = $dbh->prepare($sql);
		$sth->execute();
		my $i = 0;
		my @tblArray;
		print ">  Index  |  Title          |  Author         |  Total copies  |  Available  <\n";
		while(my $hashRef = $sth->fetchrow_hashref) {
			printf ">  %-7d|%-17.17s|%-17.17s|  %-14s|  %-11s<\n",
					$i,
					$hashRef->{'title'},
					$hashRef->{'author'},
					$hashRef->{'totalCopies'},
					$hashRef->{'copiesAvailable'}
			;
			$tblArray[$i] = $hashRef;
			$i-=-1;
		}
		print "Enter index of book you want to check in: ";
		chomp(my $checkOutBook = <STDIN>);
		
		if($tblArray[$checkOutBook]->{'copiesAvailable'} < $tblArray[$checkOutBook]->{'totalCopies'}) {
			my $cpsAvail = $tblArray[$checkOutBook]->{'copiesAvailable'} + 1;
			my $updateID = $tblArray[$checkOutBook]->{'libraryID'};
		
			$sql = "UPDATE library SET copiesAvailable = $cpsAvail WHERE (libraryID = $updateID);";
			my $result = $dbh->do($sql);
			my $title = $tblArray[$checkOutBook]->{'title'};
		
			if($result) {
				print "Successfully checked in $title\n";
			} else {
				print "Unable to check in $title\n";
			}
		} else {
			print "All copies are currently checked in.\n";
		}
		
	}
	
	print "\nWould you like to do something else? (y|n) ";
	chomp($continue = <STDIN>);
	print "\n";
}