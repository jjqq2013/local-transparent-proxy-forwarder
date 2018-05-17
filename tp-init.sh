#!/bin/bash
set -e

PROXY_HOST=${1?"require an argument as HTTP proxy host"}; shift
PROXY_PORT=${1?"require an argument as HTTP proxy port"}; shift

nohup python ./pr0cks/pr0cks.py --verbose --proxy HTTP:"$PROXY_HOST":"$PROXY_PORT --port 10080 --nat > ./proxy.log 2>&1 < /dev/null &

# listen at --local_host 0.0.0.0 is for making all docker containers can route packets to here
nohup ./node-v9.3.0-linux-x64/bin/node ./ForwardHttpToProxy/main.js --verbose 1 --local_port 10081 --remote_host "$PROXY_HOST" --remote_port "$PROXY_PORT" --local_host 0.0.0.0 > ./ForwardHttpToProxy.log 2>&1 </dev/null &
