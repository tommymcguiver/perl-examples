#!/usr/bin/perl
use Mojo::UserAgent;
use Mojo::IOLoop;
use Modern::Perl;
use Data::Printer;
use English;

# Concurrent non-blocking requests
my $ua = Mojo::UserAgent->new;
say $$;
say system("pstree -p " . $$);
		$ua->get("http://api.duckduckgo.com/?q=apple&format=json&pretty=1" => sub {
			my ($ua, $tx) = @_;
			#my $random = Dumper $tx->res->json("/RelatedTopics/1");
			my $random = $tx->res->json("/RelatedTopics/1");
			p $random;
		});
#for( 1..100 ){
	#$ua->get('http://127.0.0.1:3000/hello' => sub {
		#my ($ua, $tx) = @_;
		#p $tx->res->dom->all_text;
	#say system("pstree -p " . $$);
	#say 'Connections: ' . system("lsof -p " . $$ . " | grep ESTAB | wc -l");
	#});
#}

Mojo::IOLoop->timer($_/10 => sub { say 'GOLD'; } ) for 1..100;

# Start event loop if necessary
Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
