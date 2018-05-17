#!/bin/bash
set -e

if ! sudo iptables -t nat -n --list tp-OUTPUT >/dev/null 2>&1; then
  sudo iptables -t nat --new-chain tp-OUTPUT
fi
if ! sudo iptables -t nat -n --list tp-PREROUTING >/dev/null 2>&1; then
  sudo iptables -t nat --new-chain tp-PREROUTING
fi

sudo iptables -t nat --append OUTPUT -j tp-OUTPUT
sudo iptables -t nat --append PREROUTING -j tp-PREROUTING

#add some bypass ip
sudo iptables -t nat --append tp-OUTPUT -d 100.88.77.66 -j RETURN
sudo iptables -t nat --append tp-OUTPUT -d 100.99.88.0/24 -j RETURN

sudo iptables -t nat --append tp-OUTPUT -o eth0 -p tcp --dport 443 -m tcp -j REDIRECT --to-ports 10080
sudo iptables -t nat --append tp-OUTPUT -o eth0 -p tcp --dport 80 -m tcp -j REDIRECT --to-ports 10081

#this is for process inside docker container
sudo iptables -t nat --append tp-PREROUTING ! -i eth0 -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 10080
sudo iptables -t nat --append tp-PREROUTING ! -i eth0 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 10081
