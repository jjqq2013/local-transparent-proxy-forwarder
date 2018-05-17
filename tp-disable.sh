#!/bin/bash
set -e

if sudo iptables -t nat --check OUTPUT -j tp-OUTPUT >/dev/null 2>&1; then
  sudo iptables -t nat --delete OUTPUT -j tp-OUTPUT
fi
if sudo iptables -t nat --check PREROUTING -j tp-PREROUTING >/dev/null 2>&1; then
  sudo iptables -t nat --delete PREROUTING -j tp-PREROUTING
fi

if sudo iptables -t nat -n --list tp-OUTPUT >/dev/null 2>&1; then
  sudo iptables -t nat --flush tp-OUTPUT
  sudo iptables -t nat --delete-chain tp-OUTPUT
fi
if sudo iptables -t nat -n --list tp-PREROUTING >/dev/null 2>&1; then
  sudo iptables -t nat --flush tp-PREROUTING
  sudo iptables -t nat --delete-chain tp-PREROUTING
fi
