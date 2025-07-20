#!/bin/bash
# Block ICMP Echo Requests (ping)
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Block Traceroute UDP ports (33434–33534)
iptables -A INPUT -p udp --dport 33434:33534 -j DROP

# Optional: Allow SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Optional: Allow HAProxy HTTP (port 80)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Save rules
apt update && apt install -y iptables-persistent
netfilter-persistent save
