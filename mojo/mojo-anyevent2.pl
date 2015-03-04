#!/usr/bin/perl
use Mojolicious::Lite;
use Mojo::Server::Daemon;
use EV;
use AnyEvent;

# Normal action
get '/' => {text => 'Hello World!'};

# Connect application with web server and start accepting connections
my $daemon
  = Mojo::Server::Daemon->new(app => app, listen => ['http://*:8080']);
$daemon->start;

# Let AnyEvent take control
AE::cv->recv;
