#!/usr/bin/perl
open(PLAY, "SpotPlaylist.txt") or die("Couldn't open file.\n");

$i = 0;
my @songs;
while(chomp($songs[$i] = <PLAY>)) {
	#print "$songs[$i]\n";
	$i++;
}

$i = scalar(@songs);
$i = int(rand($i + 1));
print "You should play: $songs[$i]\n";