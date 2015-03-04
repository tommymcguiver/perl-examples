#!/bin/sh
# Send 100 async curl requests
#./async-curl-dispatcher 100

for i in $(seq 1 $1 ); do time curl -k -d ' {"jsonrpc": "2.0", "method": "hello", "id": 11, "params": ["Kenneth", "Miles"]}' -H "application/json" http://localhost:3000/ & done;
