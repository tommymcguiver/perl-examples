#!/usr/bin/perl

use AnyEvent;
use EV;
use Mojo::UserAgent;
use feature qw( say );

my $cv = AE::cv;
my $ua = Mojo::UserAgent->new;

#$cv->cb( sub { say "All URL's are done" } );
$cv->cb( sub { say "All URL's are done" } );

$cv->begin;
$ua->get( 'http://www.ozlotteries.com' => sub{
	say "Url 1 done";
	$cv->end;
});


$cv->begin;
$ua->get( 'http://www.ozlotteries.com/play' => sub{
	say "Url 2 done";
	$cv->end;
});

say "Running";
#All 3 examples work
#EV::run;
#EV::loop;
$cv->recv;
#while( 1 ) { say 'Loop ' 
	#|| $cv->recv  };
