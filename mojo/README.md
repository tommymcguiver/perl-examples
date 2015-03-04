
#How to run?

##JSONrpc2 server using mojo/anyevent talking to random blocking server.
 hypnotoad ./% -f jsonrpc_nohandle.pl
 
## Random blocking server
 hypnotoad mojo-daemon.pl -f
 
## Test responsiveness of rpc server works best with 3 threads.
./async-curl-dispatcher.sh 100
