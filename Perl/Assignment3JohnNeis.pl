# John Neis, ID: 8003486
# j.neis@und.edu
# Program 3: Practice creating a package that handles a list of songs with various
# related subroutines.

use strict;
use lib '.';
use SongList;

setTitle("My Spotify playlist");

addSong("Howdiz Songo?", "7:10");
addSong("Race to the Bridge", "6:11");
addSong("Moten Swing", "4:50");
addSong("Samba Ti Kaye", "5:18");
addSong("Bug Catcher", "5:10");
my @arr = printSongs();
print "@arr\n";

removeSong("Howdiz Songo?");
removeSong("Moten Swing");
@arr = printSongs();
print "@arr\n";

print "isSongInList(\"Moten Swing\"): ", isSongInList("mOtEn SwInG"), "\n";
print "isSongInList(\"Samba Ti Kaye\"): ", isSongInList("SaMbA tI kAyE"), "\n";

print "Number of songs: ", numberOfSongs(), "\n\n";

clear();
@arr = printSongs();
print "@arr\n";

addSong("Howdiz Songo?", "7:10");
addSong("Race to the Bridge", "6:11");
addSong("Moten Swing", "4:50");
addSong("Samba Ti Kaye", "5:18");
addSong("Bug Catcher", "5:10");

saveList("datafile.txt");
clear();
loadList("datafile.txt");
@arr = printSongs();
print "@arr\n";

setTitle("Different Title");
print getTitle(), "\n\n";

@arr = matchingSongs("i");
print "@arr\n";