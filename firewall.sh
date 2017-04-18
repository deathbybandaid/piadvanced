#!/bin/sh
## sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

## Initial 
sudo echo "*filter" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":INPUT ACCEPT [0:0]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":FORWARD ACCEPT [0:0]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":OUTPUT ACCEPT [0:0]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":fail2ban-ssh - [0:0]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
