#!/bin/sh
##Fail2Ban

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Fail2Ban" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install fail2ban?" 10 80) 
then
echo "User Declined fail2ban"
else
sudo apt-get install -y fail2ban
sudo echo "fail2banfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
