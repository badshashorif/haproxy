#!/bin/bash
# Enable UFW if not already
ufw enable

# Block ICMP Echo Requests (ping)
ufw deny proto icmp

# Block UDP traceroute
ufw deny 33434:33534/udp

# Allow SSH
ufw allow 22/tcp

# Allow HTTP
ufw allow 80/tcp

# Reload UFW to apply rules
ufw reload
