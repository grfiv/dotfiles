#!/bin/bash

# disable the response to a ping

cb "echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all"

echo "sudo su"
echo "echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all copied to clipboard"
echo "exit"
sudo su
