#!/usr/bin/perl
use AnyEvent::Socket;
use JSON::RPC2::AnyEvent::Server::Handle;  # Add `dispatch_fh' method in JSON::RPC2::AnyEvent::Server
#use JSON::RPC2::AnyEvent::Server;  # Add `dispatch_fh' method in JSON::RPC2::AnyEvent::Server
use AnyEvent;
use EV;
$|++;
 
my $srv = JSON::RPC2::AnyEvent::Server->new(
    echo => sub{
        my ($cv, $args) = @_;
        $cv->send($args);
    }
);
 
my $w = tcp_server undef, 8080, sub {
    my ($fh, $host, $port) = @_;
    my $hdl = $srv->dispatch_fh($fh);  # equivalent to JSON::RPC2::AnyEvent::Server::Handle->new($srv, $fh)
    $hdl->on_end(sub{
        #my $h = shift;  # JSON::RPC2::AnyEvent::Server::Handle
        my ($hdl, $fatal, $msg ) = @_;
        # underlying fh is already closed here
        AE::log error => $msg;
        $hdl->destroy;
        undef $hdl;
    });
    $hdl->on_error(sub{
        my ($h, $fatal, $message) = @_;
        warn $message;
        $h->destroy  if $fatal;
        undef $hdl;
    });
};

EV::run;
