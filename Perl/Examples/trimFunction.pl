#!/usr/bin/perl

sub trim {
	my $val = shift;
	if($val =~ /\s*(.*?)\s*$/) {
		$val = $1;
	}
	return $val;
}

@values = (
"asdfasdf",
"    asdfasdf",
"asdfasdf    ",
"    asdf  asdf  asdf",
"asdf  asdf  asdf    ",
"    asdf  asdf  asdf    "
);

foreach $item (@values) {
	$trimmedItem = trim($item);
	print ">$trimmedItem<\n\n";
}