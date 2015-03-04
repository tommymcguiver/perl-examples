#!/usr/bin/perl
use Mojolicious::Lite;
use Mojo::Server::Daemon;
use AnyEvent;
#use EV;

# Normal action
get '/' => sub {
	my $c = shift;
	$c->render_later;
	my $cv = AE::cv;
	my $ua = Mojo::UserAgent->new;
	$ua->get('api.metacpan.org/v0/module/_search?q=mojolicious' => sub {
		my ($ua, $tx) = @_;
		$cv->send($tx->res->json('/hits/hits/0/_source/release'));
	});
	my @results = $cv->recv;
	$c->render( json => @results );
};

# Connect application with web server and start accepting connections
my $daemon
  = Mojo::Server::Daemon->new(app => app, listen => ['http://*:8080']);
$daemon->start;

# Let AnyEvent take control
AE::cv->recv;
