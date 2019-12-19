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

sub checkParams {
    foreach my $item (param()) {
        if(!param($item)) {
            return 0;
        }
    }
    return 1;
}

if(param('btnReturn')) {
    print redirect('/cgi-bin/mainUI.pl');
    exit;
}

my $flState = 0;
if(param('btnSubmitAdd')) {
    if(checkParams) {
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
        my $sql = "INSERT INTO tblclasses VALUES(null, " .
              "'" . param('txtClassName') . "', " .
              "'" . param('txtDepartment') . "', " .
              "'" . param('txtClassNum') . "', " .
              "'" . param('txtGrade') . "', " .
              param('txtCredits') . ");";
        $dbh->do($sql);
    } else {
        $flState = 1;
    } 
}

my $sessionId = cookie('loginToken');
my $cookie = cookie(-name=>'loginToken', -value=>$sessionId, -expires=>'+30s');
print header(-cookie=>$cookie), start_html(-title=>'Add class', -BGCOLOR=>'#DDDDDD');

my $session = new CGI::Session(undef, $sessionId, {Directory=>File::Spec->tmpdir()});

if($session->param('loggedin')) {
    print start_form(-action=>'/cgi-bin/addPage.pl', -method=>'POST');
    print "<table>\n",
          "   <tr>\n",
          "      <td>Class name: </td>\n",
          "      <td><input type=text name=txtClassName maxlength=100></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td>Department: </td>\n",
          "      <td><input type=text name=txtDepartment maxlength=5></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td>Class number: </td>\n",
          "      <td><input type=text name=txtClassNum maxlength=5></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td>Grade: </td>\n",
          "      <td><input type=text name=txtGrade maxlength=1></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td>Credits: </td>\n",
          "      <td><input type=text name=txtCredits></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td><input type=submit name=btnSubmitAdd value='Add Class'></td>\n",
          "      <td><input type=submit name=btnReturn value='Return to Transcript'></td>\n",
          "   </tr>\n",
          "</table>";
    print end_form();
    
    if($flState == 1) {
        print "<font color=red>You must enter all values</font>";
    }
}
else {
    print "<p>Login timed out. Please login again ",
          a({-href=>"/index.html"}, "here"),
          ".</p>\n";
}

print end_html();