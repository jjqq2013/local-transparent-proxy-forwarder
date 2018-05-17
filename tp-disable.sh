#!/bin/bash
set -e

if iptables -t nat --check OUTPUT -j tp-OUTPUT >/dev/null 2>&1; then
  iptables -t nat --delete OUTPUT -j tp-OUTPUT
fi
if iptables -t nat --check PREROUTING -j tp-PREROUTING >/dev/null 2>&1; then
  iptables -t nat --delete PREROUTING -j tp-PREROUTING
fi

if iptables -t nat -n --list tp-OUTPUT >/dev/null 2>&1; then
  iptables -t nat --flush tp-OUTPUT
  iptables -t nat --delete-chain tp-OUTPUT
fi
if iptables -t nat -n --list tp-PREROUTING >/dev/null 2>&1; then
  iptables -t nat --flush tp-PREROUTING
  iptables -t nat --delete-chain tp-PREROUTING
fi
