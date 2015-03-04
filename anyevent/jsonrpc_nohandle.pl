#!/usr/bin/perl
use JSON::RPC2::AnyEvent::Server;
use AnyEvent;
use Mojolicious::Lite;
use EV;
use Data::Printer;

		my $ua = Mojo::UserAgent->new;

my $srv = JSON::RPC2::AnyEvent::Server->new(
	hello => "[family_name, first_name]" => sub{
		my ($cv, $args, $original_args) = @_;
		my ($family, $given) = @$args;
		#$ua->get("http://api.duckduckgo.com/?q=apple&format=json&pretty=1" => sub {
		$ua->get("http://localhost:8080/hello" => sub {
			my ($ua, $tx) = @_;
			#my $random = p $tx->res->json("/RelatedTopics/1");
			my $random = p $tx->res->json;
			$cv->send("Hello, $given $family. Random $random");
		});

		#Cannout complete
		$ua->on(error => sub {
			my ($e, $err) = @_;
			$cv->send("ERROR");
		});
	}
);

post '/' => sub{

	my $c = shift;
	$c->render_later;

	my $cv = $srv->dispatch( $c->req->json );
	#$c->render( json => $cv->recv );
		
	$cv->cb( sub{
		$c->render( json => $_[0]->recv );
	} );
	undef $cv;
	#Long winded way of getting the results
	#Mojo::IOLoop::Delay->new->steps(
		#sub{
			#my $d = shift;
			##Doesn't block but calback does
			#$cv->cb( $d->begin );
		#},
		#sub{
			#my $d = shift;
			#$c->render( json => shift->recv );
		#}
	#);
	
};
app->config(hypnotoad => {workers => 10, listen => ['http://*:3000'] });
app->start;
#my $daemon
  #= Mojo::Server::Daemon->new(app => app);
  #$daemon->start;

  ## Let AnyEvent take control
   #EV::loop;
#mr $res = $cv->recv;  # { jsonrpc => "2.0", id => 1, result => "Hello, Kyo Sogoru!" }

#use Data::Printer;
#p $res;
 
#$cv = $srv->dispatch({
		#jsonrpc => "2.0",
		#id		=> 2,
		#method	=> 'hello',
		#params	=> {first_name => 'Ryoko', family_name => 'Kaminagi'}  # You can pass a hash as well!
	#});
#my $res = $cv->recv;  # { jsonrpc => "2.0", id => 2, result => "Hello, Ryoko Kaminagi!" }

## For Notification Request, just returns undef.
#my $cv = $srv->dispatch({
		#jsonrpc => "2.0",
		#method	=> "hello",
		#params	=> ["Misaki", "Shizuno"]
	#});  # notification request when "id" is omitted.
#not defined $cv;  # true
