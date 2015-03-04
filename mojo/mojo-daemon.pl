#!/usr/bin/perl
use Mojolicious::Lite;
use ojo;

app->config(hypnotoad => {workers => 100, listen => ['http://*:8080'] });
a("/hello" => sub { my $sleeper = sleep int(rand(5)); $_->render(json => {hello => "world", slept => $sleeper}) })->start;
