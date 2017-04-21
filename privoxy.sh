#!/bin/sh
## Privoxy
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Privoxy?" 8 78) then



echo "not installing stuff"

else

echo "installing stuff"
sudo echo "# Privoxy" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 8118 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules


fi }
