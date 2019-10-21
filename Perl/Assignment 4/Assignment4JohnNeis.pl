#!/usr/bin/perl

# John Neis, ID 8003486
# j.neis@und.edu
# Program 4: Use regular expressions to extract variable and method
# names from a syntactically correct java file
use strict;

if(scalar(@ARGV) < 1) {
	print "Please enter a filename to open: ";
	chomp(my $in = <STDIN>);
	open(JAVAFILE, $in) or die("Unable to open file.\n");
} else {
	open(JAVAFILE, $ARGV[0]) or die("Unable to open file.\n");
}

my $type = "(int|double|boolean|String|void)";

my ($input, %vars);
while(chomp($input = <JAVAFILE>)) {
	
	$input =~ s/^\s+//;
	
	if($input =~ /$type\s+(\w+)(\(.*\))/g) {
		$vars{"Method"} = $vars{"Method"} . " " . $2;
	} 
	elsif($input =~ /$type\s+(\w+)((,\s+\w+)+)?/g) {
		
		my @fixed = split(/,\s+/, $3);
		my $i;
		for($i = 0, $i < scalar(@fixed), $i++) {
			$fixed[$i] =~ s/^\s+//;
		}
		$vars{$1} = $vars{$1} . " " . $2;
		for($i = 0; $i < scalar(@fixed); $i++) {
			$vars{$1} = $vars{$1} . " " . $fixed[$i];
		}
	}
}

close(JAVAFILE) or die("Error: $!");

foreach my $key (sort{lc($a) cmp lc($b)}(keys(%vars))) {
	my @symbols = sort{lc($a) cmp lc($b)}(split(/\s+/, $vars{$key}));
	
	print "$key:\n";
	my $i;
	for($i = 1; $i < scalar(@symbols); $i++) {
		print "\t$symbols[$i]\n";
	}
}