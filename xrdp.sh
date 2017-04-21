#!/bin/sh
## XRDP
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install xrdp?" 8 78) then
echo "User Declined xrdp"
else
sudo apt-get install -y xrdp
sudo echo "# XRDP" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 3389 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --dport 3389 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 3350 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --dport 3350 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 5910 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --dport 5910 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }
