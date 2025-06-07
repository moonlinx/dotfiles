#!/bin/bash

# This script is used to check available IP addrs on my network
# I know that ping is not the most effective but this is an early version
#

# Scan network using ping
check_ips() {
  for i in $(seq 1 254); do
    ping -c 1 -q 192.168.1.$i &
  done
}

# Use arp table that host has acquired to tell me which ips have associated macs
arp_scan() {
  arp -a | grep 192.168.1. | grep ether >>scan.md
}

check_ips
arp_scan
