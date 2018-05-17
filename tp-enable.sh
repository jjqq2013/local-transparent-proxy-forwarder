#!/bin/bash
set -e

PROXY_HOST=${1?"require an argument as HTTP proxy host"}; shift
BYPASS_IP_SEGMENTS=${1?"require an argument as bypass IP segments, example: 100.99.88.0/24"}; shift
OUTPUT_INTERFACE=${1?"require an argument as output interface, example: eth0"}; shift

if ! sudo iptables -t nat -n --list tp-OUTPUT >/dev/null 2>&1; then
  sudo iptables -t nat --new-chain tp-OUTPUT
fi
if ! sudo iptables -t nat -n --list tp-PREROUTING >/dev/null 2>&1; then
  sudo iptables -t nat --new-chain tp-PREROUTING
fi

sudo iptables -t nat --append OUTPUT -j tp-OUTPUT
sudo iptables -t nat --append PREROUTING -j tp-PREROUTING

#add some bypass ip
sudo iptables -t nat --append tp-OUTPUT -d "$PROXY_HOST" -j RETURN
sudo iptables -t nat --append tp-OUTPUT -d "$BYPASS_IP_SEGMENTS" -j RETURN

sudo iptables -t nat --append tp-OUTPUT -o "$OUTPUT_INTERFACE" -p tcp --dport 443 -m tcp -j REDIRECT --to-ports 10080
sudo iptables -t nat --append tp-OUTPUT -o "$OUTPUT_INTERFACE" -p tcp --dport 80 -m tcp -j REDIRECT --to-ports 10081

#this is for process inside docker container
sudo iptables -t nat --append tp-PREROUTING ! -i "$OUTPUT_INTERFACE" -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 10080
sudo iptables -t nat --append tp-PREROUTING ! -i "$OUTPUT_INTERFACE" -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 10081
