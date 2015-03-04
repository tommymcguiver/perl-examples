#!/usr/bin/perl
use AnyEvent; # not AE
use Modern::Perl;
use EV;

my $cv = AE::cv; # stores whether a condition was flagged

# one-shot or repeating timers
my $seconds = 1;
my $howdy = AE::timer $seconds, 1, sub {
	say 'Howdy after ' . $seconds . ' seconds ';
}; # once

#Terminate after 5 seconds
#WTF does not terminate?
#my $w3 = AE::timer 5, 0, sub { $cv }; # repeated

#print AE::now;  # prints current event loop time
#print AE::time; # think Time::HiRes::time or simply CORE::time.

# POSIX signal
my $w1 = AE::signal TERM => sub { say q( I've been termed. ) };
my $w2 = AE::signal INT => sub { say q( I've been Int'ed. ) };

# child process exit
#my $w = AE::child $pid, sub {
	#my ($pid, $status) = @_;
	#...
#};

# called when event loop idle (if applicable)
#my $w = AE::idle sub { print 'How about now' . AE::now; };

	#EV/AE needs references to run event handlers. If out of scope they stop. If EV::loop is running
	#the event handler we stop.
	#my $w3 = AE::timer 5, 0, sub { undef $w1; undef $w2; undef $w; undef $howdy; }; # repeated
	#Send kills the program.
my $w4 = AE::timer 5, 0, sub { $cv->send( 'Send ') }; # repeated

	## use a condvar in callback mode:
$cv->cb (sub { say 'Stuff' .  $_[0]->recv });


#Keyboard input!
#my $stdin_ready = AE::io *STDIN, 0, sub { print STDOUT "hi\n" };
#my $stdout_ready = AE::io *STDOUT, 1, sub { print STDOUT "woaw\n" };

EV::loop;
#$cv->recv
