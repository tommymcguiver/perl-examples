#!/usr/bin/perl
use Mojo::UserAgent;
use EV;
use AnyEvent;
use Modern::Perl;

# Search MetaCPAN for "mojolicious"
my $cv = AE::cv;
my $ua = Mojo::UserAgent->new;
$ua->get('api.metacpan.org/v0/module/_search?q=mojolicious' => sub {
  my ($ua, $tx) = @_;
  $cv->send($tx->res->json('/hits/hits/0/_source/release'));
});
#my @results = $cv->recv;
say $_ for $cv->recv;
