#!/bin/sh
#rpimonitor

sudo echo "# rpi monitor" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 8889 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
