#!/usr/bin/perl
#
use AnyEvent::HTTP;
use AnyEvent;

my $cv = AE::cv; # stores whether a condition was flagged

#http_get "http://www.nethype.de/", sub { print 'hi' . $_[1] };
 http_request GET => "http://www.nethype.de/", sub {
      my ($body, $hdr) = @_;
      print "$body\n";
   };

$cv->recv;
