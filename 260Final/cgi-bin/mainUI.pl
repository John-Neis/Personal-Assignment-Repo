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

sub connectToDB {
    my $datasource = "DBI:mysql:f19final:localhost";
    my $user = "root";
    my $pwd  = "pass260word";
    my $dbh  = DBI->connect($datasource, $user, $pwd);

    if(!$dbh) {
        print header(), start_html(-title=>"Database Error", -BGCOLOR=>"#DDDDDD");
        print "Unable to reach database. Please try again later.", "\n";
        print end_html();
        exit;
    } else {
        return $dbh;
    }
}

my $sessionId = cookie('loginToken');
my $session = new CGI::Session(undef, $sessionId, {Directory=>File::Spec->tmpdir()});
my $cookie = cookie(-name=>'loginToken', -value=>$sessionId, -expires=>'+30s');
my $dbhandle = connectToDB();
my %gradeStats;

print header(-cookie=>$cookie);
print "<html>\n",
      "   <header>\n",
      "      <title>Transcript - Main</title>\n",
      "      <link rel='icon' href='/f19Icon.ico'>\n",
      "      <style>\n",
      "         p { \n",
     #"            font-family: 'Courier New';\n",
      "            padding-left: 5%;\n",
      "            padding-top: 2%;\n",
      "         }\n",
      "         div.bod {\n",
     #"            font-family: 'Courier New';\n",
      "            position: relative;\n",
      "            top: 5%;\n",
      "            left: 5%;\n",
      "            width: 90%;\n",
     #"            height: 90%;\n",
     #"            border: 1px solid black;\n",
     #"            background-color: lightskyblue;\n",
      "         }\n",
      "         div.tab {\n",
      "            position: relative;\n",
      "            top: 5%;\n",
      "            left: 25%;\n",
      "         }\n",
      "         div.frm {\n",
      "            position: absolute;\n",
      "            top: 5%;\n",
      "            left: 2%;\n",
     #"            width: 40%;\n",
     #"            border: 1px dashed black;\n",
      "         }\n",
      "         div.stats {\n",
      "            position: absolute;\n",
      "            top: 2%;\n",
      "            right: 30%;\n",
      "         }\n",
      "         table {\n",
      "            border: 1px solid black;\n",
      "            border-collapse: collapse;\n",
      "         }\n",
      "         td, th {\n",
      "            border: 1px solid black;\n",
      "            padding: 3px;\n",
      "         }\n",
      "      </style>\n",
      "   </header>\n",
      "   <body bgcolor='#DDDDDD' background='index.jpeg'>\n";


print "<div class=bod>";

if($session->param('loggedin')) {
    my $cookie = cookie(-name=>"loginToken", -value=>$session->id, -expires=>'+30s');
    
    my $searchCrit = param("txtSearchCrit");
    my $sql = "SELECT * FROM tblclasses where " .
              "classname LIKE '%" . $searchCrit . "%' or " .
              "department LIKE '%" . $searchCrit . "%' or " .
              "classnum LIKE '%" . $searchCrit . "%' or " .
              "grade LIKE '$searchCrit';";

    my $sth = $dbhandle->prepare($sql);
    $sth->execute();
        
    print "<div class=frm>\n",
          "<table>\n",
          start_form(-method=>"POST", -action=>'/cgi-bin/mainUI.pl'),
          "<tr><td><input type=text name=txtSearchCrit placeholder='Enter search criteria'>\n", br,
          "<input type=submit name=btnSearch value=Search></td></td>\n",
          end_form(), "\n", 
          "<tr><td><a href='addPage.pl'><input type=submit name=btnAddclass value='Add Class'></a></td></td>\n",
          "<tr><td><a href='editPage.pl'><input type=submit name=btnEditclass value='Edit Class'></a></td></td>\n",
          "</table>",
          "</div>\n";
    print "<div class='tab'><table>\n";
    print "<tr>\n",
          "   <th>Department</th>\n",
          "   <th>Class Number</th>\n",
          "   <th>Class Name</th>\n",
          "   <th>Grade</th>",
          "</tr>\n";
    while(my $hashRef = $sth->fetchrow_hashref) {
        print "<tr>",
              "   <td>$hashRef->{department}</td>\n",
              "   <td>$hashRef->{classnum}</td>\n",
              "   <td>$hashRef->{classname}</td>\n",
              "   <td>$hashRef->{grade}</td>\n";
        $gradeStats{"creditsAttempted"} += $hashRef->{credits};
        if($hashRef->{grade} ne 'F' && 
           $hashRef->{grade} ne 'f' && 
           $hashRef->{grade} ne 'W' && 
           $hashRef->{grade} ne 'w') {
            $gradeStats{"creditsPassed"} += $hashRef->{credits};
        }
        if($hashRef->{grade} eq 'A' || $hashRef->{grade} eq 'a') {
            $gradeStats{GPA} += $hashRef->{credits} * 4;
        } elsif($hashRef->{grade} eq 'B' || $hashRef->{grade} eq 'b') {
            $gradeStats{GPA} += $hashRef->{credits} * 3;
        } elsif($hashRef->{grade} eq 'C' || $hashRef->{grade} eq 'c') {
            $gradeStats{GPA} += $hashRef->{credits} * 2;
        } elsif($hashRef->{grade} eq 'D' || $hashRef->{grade} eq 'd') {
            $gradeStats{GPA} += $hashRef->{credits};
        } else {
            $gradeStats{GPA} += 0;
        }
    }
    $gradeStats{GPA} /= $gradeStats{creditsPassed};
    print "</table>", br, "\n";
    print "<div class=stats>\n";
    print "Credits Attempted: $gradeStats{creditsAttempted}", br, "\n";
    print "Credits Passed: $gradeStats{creditsPassed}", br, "\n";
    printf "Current GPA: %.3f\n", $gradeStats{GPA};
    print "</div>\n";

    print "</div>\n";
    

} else {
    print "<p>Login timed out. Please login again ",
          a({-href=>"/index.html"}, "here"),
          ".</p>\n";
}
print "</div>";

print end_html();