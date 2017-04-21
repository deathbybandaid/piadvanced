#!/bin/sh
#rpimonitor
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install rpimonitor?" 8 78) then
echo "User decline rpimonitor"
else
sudo wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list
sudo apt-get install -y rpimonitor
sudo /etc/init.d/rpimonitor update
sudo echo "# rpi monitor" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 8889 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }
