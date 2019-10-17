# John Neis, ID: 8003486
# j.neis@und.edu
# Program 3: Practice creating a package that handles a list of songs with various
# related subroutines.

package SongList;


use strict;
use Exporter;
our @ISA = qw /Exporter/;
our @EXPORT = qw /&addSong &removeSong &isSongInList &numberOfSongs &clear &printSongs &saveList &loadList &setTitle &getTitle &matchingSongs/;

my %songs;

$songs{title} = undef;

sub addSong {
	my ($title, $time);
	if(scalar(@_) != 2) {
		print "Incorrect number of args provided";
		return;
	}
	($title, $time) = (shift, shift);
	$songs{$title} = $time;
}

sub removeSong {
	if(scalar(@_) != 1) {
		print "Incorrect number of args provided";
		return;
	}
	my $rec = shift;
	if(isSongInList($rec)) {
		delete $songs{$rec};
		return 1;
	} else {
		return 0;
	}
	
}

sub isSongInList {
	if(scalar(@_) != 1) {
		print "Incorrect number of args provided";
		return;
	}
	
	my $rec = lc(shift);
	foreach my $key (keys(%songs)) {
		if($rec eq lc($key)) {
			return 1;
		}
	}
	return 0;
}

sub numberOfSongs {
	my $size = scalar(%songs) - 1;
	return $size;
}

sub clear {
	my $title = $songs{title};
	undef %songs;
	$songs{title} = $title;
}

sub printSongs {
	print "Title: $songs{title}\n";
	my (@arr, $index);
	$index = 0;
	foreach my $key (sort {lc($a) cmp lc($b)}(keys(%songs))) {
		if(!($key eq "title")) {
			$arr[$index] = sprintf("%-20s -> %6s\n",$key, $songs{$key});
			$index++;
		}
	}
	return @arr;
}

sub saveList {
	if(scalar(@_) != 1) {
		print "Incorrect number of args provided";
		return;
	}
	
	my $file = shift;
	my $result = open(SAVEFILE, ">" . $file);
	if($result) {
		print SAVEFILE "title, $songs{title}\n";
		foreach my $key (sort{lc($a) cmp lc($b)}keys(%songs)) {
			if(!($key eq "title")) {
				print SAVEFILE "$key, $songs{$key}\n";
			}
		}
		close(SAVEFILE) or die("Error: $!\n");
		return 1;
	} else {
		return 0;
	}
}

sub loadList {
	if(scalar(@_) != 1) {
		print "Incorrect number of args provided";
		return;
	}
	undef %songs;
	
	my $file = shift;
	my ($input, @splitArr);
	my $result = open(LOADFILE, $file) or die("Error: $!\n");
	if($result) {
		while(chomp($input = <LOADFILE>)) {
			@splitArr = split(", ", $input);
			$songs{$splitArr[0]} = $splitArr[1];
		}
		close(LOADFILE) or die("Error: $!\n");
		return 1;
	} else {
		return 0;
	}
}

sub setTitle {
	if(scalar(@_) != 1) {
		print "Incorrect number of args provided";
		return;
	}
	$songs{title} = shift;
}

sub getTitle {
	return $songs{title};
}

sub matchingSongs {
	if(scalar(@_) != 1) {
		print "Incorrect number of args provided";
		return;
	}
	my $search = shift;
	my ($index, @matches);
	$index = 0;
	foreach my $key (sort{lc($a) cmp lc($b)}keys(%songs)) {
		if(index($key, $search) != -1 && !($key eq "title")) {
			@matches[$index] = $key . "\n";
			$index++;
		}
	}
	return wantarray ? @matches : \@matches;
}

1;