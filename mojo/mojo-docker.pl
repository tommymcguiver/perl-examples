#!/usr/bin/perl
use Mojo::UserAgent;
use Data::Printer;

# Say hello to the Unicode snowman with "Do Not Track" header
my $ua = Mojo::UserAgent->new;
#$ua->ca($ENV{DOCKER_CERT_PATH}. '/b2d-client-side.p12');
#$ua->cert($ENV{DOCKER_CERT_PATH}. '/cert.pem');
#$ua->key($ENV{DOCKER_CERT_PATH}. '/key.pem');

Mojo::IOLoop->delay(
    sub {
        my $delay = shift;
        #$ua->get('https://192.168.59.103:2376/events?since=1374067924' => $delay->begin);
        $ua->get('http://192.168.59.103:2375/v1.17/events' => $delay->begin);
    },
    sub {
        my ($delay, $mojo) = @_;
        p $mojo->res
    }
)->wait;
