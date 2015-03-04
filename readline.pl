#!/usr/bin/perl
use Term::ReadLine;
use feature qw( say );

my $t = Term::ReadLine->new('program name');
while (defined($_ = $t->readline('prompt> '))) {
    $t->addhistory($_) if /\S/;
	say $_;
}
