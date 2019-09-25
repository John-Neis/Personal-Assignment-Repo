# Stokke did all this

use strict;
#use warnings;

my (@numArray, @strArray, $value, @sortedNumbers);
my (@sortedStrings);

@numArray = (-1, 3, -5, -7, -9, 11..15, 17);
@strArray = ("A", 'b', 'C', 'qwer', '45', '*&', 'a'..'d');

print "First value ", $numArray[0], "\n";
print "First value $numArray[0]\n";
print "First value ", @numArray[0], "\n";
print "Last value $numArray[-1]\n";
print "Last value $numArray[$#numArray]\n";
print "Last value $numArray[scalar(@numArray) -1]\n";
print "Size of numArray ", scalar(@numArray), "\n";
print "Dumping out values with for\n";
for (my $index; $index < scalar(@numArray); ++$index)
{
   #print "$index $numArray[$index]\n";
   printf "%-5d%5d\n", $index, $numArray[$index];
}
print "\nDumping out values with foreach\n";
foreach $value (@numArray) 
{
   print "$value\n";
   $value *= 2; #$values = $value * 2
}

print "numArray  @numArray\n";
@sortedNumbers = sort (@numArray);
print "@sortedNumbers\n";
@sortedNumbers = sort {abs($a) <=> abs($b)} (@numArray);
print "@sortedNumbers\n";
$numArray[20] = 1000;
print "numArray  @numArray\n";
print "strArray @strArray\n";
@sortedStrings = sort {lc($a) cmp lc($b)} @strArray;
print "Sorted strings @sortedStrings\n";
