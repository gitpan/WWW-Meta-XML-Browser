#!/usr/local/bin/perl -w

use strict;

use WWW::Meta::XML::Browser;

my $term_readkey = 1;
eval "use Term::ReadKey;";
$term_readkey = 0 if $@;


print "Bitte die Kontonummer eingeben: ";
my $kontonr = <STDIN>;
chomp($kontonr);

ReadMode('noecho') if $term_readkey;
print "ACHTUNG! Die PIN wird auf dem Schirm ausgegeben, da Term::ReadKey nicht installiert ist.\n" if !$term_readkey;
print "Bitte die PIN eingeben: \n";
my $pin = <STDIN>;
chomp($pin);
ReadMode(0) if $term_readkey;


my $browser = WWW::Meta::XML::Browser->new(
	args =>		{
					"kontonr"	=> $kontonr,
					"pin"		=> $pin
				},
	debug =>	1
);
$browser->process_file('sparkasse-banking.xml');
$browser->process_all_request_nodes();
$browser->print_request_result($browser->get_request_result(1,0));