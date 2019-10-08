#####################################################################################
# John Neis, j.neis@und.edu                                                         #
# Program 1                                                                         #
#####################################################################################

#####################################################################################
# Part 1: Have the user enter a full name in "first last" format.                   #
# The program will then output 5 lines:                                             #
# First name; last name; last name, first name; FIRST LAST; first name\nlast name   #
#####################################################################################
$| = 1;
use strict;
print "Part 1:\n";

my ($full_name, $first_name, $last_name);
print "Please enter a full name (first last): ";
chomp($full_name = <STDIN>);

# To get the first name, start at index 0 and go to the index of " "
$first_name = substr($full_name, 0, index($full_name, " "));
print "First name: $first_name\n";

# To get the last name, start at index of " " + 1 and go to the length of the string
$last_name = substr($full_name, index($full_name, " ") + 1, length($full_name));
print "Last name: $last_name\n";

# To print last, first just put the previous 2 prints together
print "Last, First: $last_name, $first_name\n";

# To print FIRST LAST, use uc()
print "FIRST LAST: ", uc($full_name), "\n";

# I'd explain this one but I think you get the point
print "First \\n Last: $first_name\n$last_name\n";

#####################################################################################
# Part 2: The user will input a 3 digit number                                      #
# The program will then print the hundred's place, ten's place, and one's place     #
# and the original number.                                                          #
#####################################################################################
print "\nPart 2:\n";

my ($the_number, $hundreds, $tens);
print "Please enter a 3 digit number: ";
chomp($the_number = <STDIN>);

# To extract hundred's digit, number / 100 gives a decimal value, whose int value is what we want
$hundreds = int($the_number / 100);
printf "Hundred's place:%11d\n", $hundreds;

# We no longer need the hundred's place
$the_number = $the_number - $hundreds * 100;

# To extract ten's digit, number / 10 gives a decimal value, and I'm explaining the same thing twice
$tens = int($the_number / 10);
printf "Ten's place:%15d\n", $tens;

# We no longer need the ten's place
$the_number = $the_number - $tens * 10;

# What's left is the one's place
printf "One's place:%15d\n", $the_number;

# This is me realizing I needed the original number again, so reassemble the thing
$the_number = $the_number + $tens * 10 + $hundreds * 100;
printf "Original number:%11d\n", $the_number;
