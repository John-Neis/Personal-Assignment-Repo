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

my $session = new CGI::Session(undef, undef, {Directory=>File::Spec->tmpdir()});

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

sub logInUser {
    my $dbh = shift;
    my $username = shift;
    my $password = shift;
    
    if(!($dbh && $username && $password)) {
        print header(), start_html(-title=>"Login Error", -BGCOLOR=>"#DDDDDD");
        print "Unable to login. Make sure all fields have values.", "\n";
        print end_html();
        exit;
    }

    my $sql = "SELECT 1 FROM tblusers WHERE login = '$username' AND password = '$password';";
    my $result = $dbh->do($sql);

    $result =~ s/(\d).*/$1/g;
    if($result) {
        return $result;
    } else {
        return $result;
    }
    return 0;
}

if(-t) {
    my $cookie = cookie(-name    => "loginToken",
                        -value   => param("txtUserName") . " " . param("txtPassword"),
                        -expires => '+30s'
                  );
    print redirect(-cookie=>$cookie, -location=>"/index.html");
    exit;
}

my $dbhandle = connectToDB();
my $logResult = logInUser($dbhandle, param("txtUserName"), param("txtPassword"));

if($logResult) {
    my $cookie;
    $session->param('loggedin', 1);
    $session->param('username', param("txtUserName"));

    if(param("chkIndefSignin")) {
        $cookie = cookie(-name  => "loginToken",
                         -value => $session->id
                  );
    } else {
        
        $cookie = cookie(-name    => "loginToken",
                         -value   => $session->id,
                         -expires => '+30s'
                  );
    }
    print redirect(-cookie=>$cookie, -location=>"/cgi-bin/mainUI.pl");
} else {
    print header(), start_html(-title=>"Login Error", -BGCOLOR=>"#DDDDDD");
    print "Invalid login.", "\n";
    print end_html();
}