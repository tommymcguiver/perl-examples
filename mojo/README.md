
#How to run?

##JSONrpc2 server using mojo/anyevent talking to random blocking server.
 hypnotoad ./jsonrpc_nohandle.pl -f 
 
## Random blocking server
 hypnotoad mojo-daemon.pl -f
 
## Test responsiveness of rpc server works best with 3 threads.
./async-curl-dispatcher.sh 100
