#!/usr/bin/perl
use strict;

if(scalar(@ARGV) != 1) {
	print "Incorrect number of args.\n";
	exit;
}

my $type   = "(int|double|boolean|String|void)";

open(JAVAFILE, $ARGV[0]) or die("Unable to open file.\n");

my ($input, %symbols);

print "Regex: \n";
while(chomp($input = <JAVAFILE>)) {
    if($input =~ /$type\s+(\w+)(\((($type)\s+(\w+))\))?/) {
        #print "$1, $2, $6, $7\n";
        if(!($6 eq "")) { $symbols{$2} = "Method"; $symbols{$7} = $6; }
        elsif($2 eq "main") { $symbols{$2} = "Method"; }
        else { $symbols{$2} = $1; }
    }
}
close(JAVAFILE) or die("Error: $!");

print "\n";
foreach my $key (sort(keys(%symbols))) {
    print "$key -> $symbols{$key}\n";
}
