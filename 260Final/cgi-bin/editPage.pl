#!/usr/bin/perl

# John Neis, ID: 8003486
# j.neis@und.edu
# Final Project: Create a website that allows a user to login, add, edit, and view
# a college transcript.

use CGI qw(:standard);
use CGI::Session;
use File::Spec;
use DBI;
use strict;

my $sessionId = cookie('loginToken');
my $cookie = cookie(-name=>'loginToken', -value=>$sessionId, -expires=>'+30s');
print header(-cookie=>$cookie), start_html(-title=>'Edit Class', -BGCOLOR=>'#DDDDDD');

my $session = new CGI::Session(undef, $sessionId, {Directory=>File::Spec->tmpdir()});

if($session->param('loggedin')) {
    my $datasource = "DBI:mysql:f19final:localhost";
    my $user = "root";
    my $pwd  = "pass260word";
    my $dbh  = DBI->connect($datasource, $user, $pwd);

    if(!$dbh) {
        print header(), start_html(-title=>"Database Error", -BGCOLOR=>"#DDDDDD");
        print "Unable to reach database. Please try again later.", "\n";
        print end_html();
        exit;
    }

    my $sql = "SELECT * FROM tblclasses;";
    my $sth = $dbh->prepare($sql);
    $sth->execute();
    print "<table style='border: 1px solid black; border-collapse: collapse;'>\n";
    while(my $hashRef = $sth->fetchrow_hashref) {
        print "<tr>\n";
        print "<td style='border: 1px solid black; padding: 3px;'>", $hashRef->{'classname'}, 
              "</td><td style='border: 1px solid black; padding: 3px;'><a href='editEntry.pl?id=$hashRef->{classID}'>Edit</a></td>";
        print "</tr>";
    }
    print "</table>\n";
    print a({-href=>"/cgi-bin/mainUI.pl"}, "<input type=button value='Return to Transcript'>");
} else {
    print "<p>Login timed out. Please login again ",
          a({-href=>"/index.html"}, "here"),
          ".</p>\n";
}

print end_html();