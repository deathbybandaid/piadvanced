#!/bin/sh
##Fail2Ban
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install fail2ban?" 8 78) then
echo "User Declined fail2ban"
else
sudo apt-get install -y fail2ban
sudo echo "fail2banfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
