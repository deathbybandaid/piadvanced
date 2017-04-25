#!/bin/sh
## sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
sudo rm -r /etc/iptables.firewall.rules
## Initial 
sudo echo "*filter" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":INPUT ACCEPT [0:0]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":FORWARD ACCEPT [0:0]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":OUTPUT ACCEPT [0:0]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":fail2ban-ssh - [0:0]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "#  Allow HTTP and HTTPS connections from anywhere (the normal ports for websites and SSL)." | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 80 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 443 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "# Allows SMTP access" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 25 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 465 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 587 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "# Allows pop and pops connections" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 110 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 995 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "# Allows imap and imaps connections" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 143 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 993 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "#  Allow ping" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p icmp --icmp-type echo-request -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "#  Log iptables denied calls" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "#-A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "#" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "# DHCP" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --dport 67 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --dport 68 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "#  Accept all established inbound connections" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "#  Allow all outbound traffic - you can modify this to only allow certain traffic" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A OUTPUT -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "# DNS" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --destination-port 53 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --destination-port 53 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --destination-port 80 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --destination-port 80 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
