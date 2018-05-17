nohup python ./pr0cks/pr0cks.py --verbose --proxy HTTP:100.88.77.66:9999 --port 10080 --nat > ./proxy.log 2>&1 < /dev/null &
nohup ./node-v9.3.0-linux-x64/bin/node ./ForwardHttpToProxy/main.js --verbose 1 --local_port 10081 --remote_host 100.88.77.66 --remote_port 9999 --local_host 0.0.0.0 > ./ForwardHttpToProxy.log 2>&1 </dev/null &
