use strict;

my $x;
my $y;
my ($intAnswer, $strAnswer, $answer1, $answer2, $z, $z1, $c);

$x = 10;
$y = 20;
$z = "123 asdfasdf";
$z1 = "asdf1234asdf";

$intAnswer = $x + $y;
$strAnswer = $x . $y;
$answer1 = $x + $z;
$answer2 = $x + $z1;

print ("The int answer is $intAnswer\n");
print ("The string answer is $strAnswer\n");

print ("Answer1 is $answer1\n");
print ("Answer2 is $answer2\n");
print ("The value of C is ",  int($c), "\n");

# Last line doesn't exactly need a semicolon.
