#!/bin/sh
##Fail2Ban
{ if (whiptail --yesno "Do you want to install fail2ban?" 8 78) then
sudo apt-get install -y fail2ban
sudo echo "# Fail2Ban" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp -m multiport --dports 22 -j fail2ban-ssh" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
else
echo ""
fi }
