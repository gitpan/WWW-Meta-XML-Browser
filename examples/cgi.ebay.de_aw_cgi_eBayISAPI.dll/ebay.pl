#!/usr/local/bin/perl -w

use strict;

use WWW::Meta::XML::Browser;

my $term_readkey = 1;
eval "use Term::ReadKey;";
$term_readkey = 0 if $@;


print "Bitte den ebay-Usernamen eingeben: ";
my $username = <STDIN>;
chomp($username);

ReadMode('noecho') if $term_readkey;
print "ACHTUNG! Das Passwort wird auf dem Schirm ausgegeben, da Term::ReadKey nicht installiert ist.\n" if !$term_readkey;
print "Bitte das ebay-Passwort eingeben: \n";
my $password = <STDIN>;
chomp($password);
ReadMode(0) if $term_readkey;

my $browser = WWW::Meta::XML::Browser->new(
	args =>		{
					"username"	=> $username,
					"password"	=> $password
				},
	debug => 1
);
$browser->process_file('MyeBayItemsBiddingOn.xml');
$browser->process_all_request_nodes();
$browser->print_request_result($browser->get_request_result(1,0));