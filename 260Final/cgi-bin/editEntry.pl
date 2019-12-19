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

my $flState = 0;
my $id = param('id');
my ($sth, $sql);
my $sessionId = cookie('loginToken');
my $session = new CGI::Session(undef, $sessionId, {Directory=>File::Spec->tmpdir()});
my $cookie = cookie(-name=>'loginToken', -value=>$sessionId, -expires=>'+30s');

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

sub checkParams {
    foreach my $item (param()) {
        if(!param($item)) {
            return 0;
        }
    }
    return 1;
}

if(param('btnReturn')) {
    print redirect('/cgi-bin/editPage.pl');
    exit;
}

if(param('btnSubmitEdit')) {
    if(checkParams) {
        #$id = param('id');
        $sql = "UPDATE tblclasses SET ".
                    "classname = '" . param('txtClassName') . "', " .
                    "department = '" . param('txtDepartment') . "', " .
                    "classnum = '" . param('txtClassNum') . "', " .
                    "grade = '" . param('txtGrade') . "', " .
                    "credits = " . param('txtCredits') . 
                    " WHERE classID = $id;";
        $dbh->do($sql);
        print redirect('/cgi-bin/editPage.pl');
        exit;
    } else {
        $flState = 1;
    }
}

print header(-cookie=>$cookie), start_html(-title=>'Edit Class', -BGCOLOR=>'#DDDDDD');

if($session->param('loggedin')) {
    #print $sql;
    
    $sql = "SELECT * FROM tblclasses WHERE classID = $id;";
    $sth = $dbh->prepare($sql);
    $sth->execute();
    my $hR = $sth->fetchrow_hashref;
    print start_form(-action=>"/cgi-bin/editEntry.pl?id=$id", -method=>'POST');
    print "<table>\n",
          "   <tr>\n",
          "      <td>Class name: </td>\n",
          "      <td><input type=text name=txtClassName maxlength=100 value='$hR->{classname}'></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td>Department: </td>\n",
          "      <td><input type=text name=txtDepartment maxlength=5 value='$hR->{department}'></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td>Class number: </td>\n",
          "      <td><input type=text name=txtClassNum maxlength=5 value='$hR->{classnum}'></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td>Grade: </td>\n",
          "      <td><input type=text name=txtGrade maxlength=1 value='$hR->{grade}'></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td>Credits: </td>\n",
          "      <td><input type=text name=txtCredits value='$hR->{credits}'></td>\n",
          "   </tr>\n",
          "   <tr>\n",
          "      <td><input type=submit name=btnSubmitEdit value='Edit Class'></td>\n",
          "      <td><input type=submit name=btnReturn value='Return to Edit List'></td>\n",
          "      <td><input type=hidden name=id value=$id></td>",
          "   </tr>\n",
          "</table>";
    print end_form();
    if($flState == 1) {
        print "<font color=red>You must enter all values</font>";
    }
} else {
    print "<p>Login timed out. Please login again ",
          a({-href=>"/index.html"}, "here"),
          ".</p>\n";
}

print end_html();