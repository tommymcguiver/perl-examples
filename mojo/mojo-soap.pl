#!/usr/bin/perl
#
use SOAP::Lite; # +trace => 'all';
use SOAP::Transport::HTTP;  # preload it so that we can set USERAGENT_CLASS reliably;
use Data::Printer;
#$SOAP::Transport::HTTP::Client::USERAGENT_CLASS = "Mojo::UserAgent";

my $client = SOAP::Lite->proxy('https://demo.ippayments.com.au/interface/api/dts.asmx')->uri('http://www.ippayments.com.au/interface/api/dts/');
my $som = $client->IPPAPIAlive();
p $som;
