#!/bin/sh
## Squid

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Squid" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Squid and Squidguard?" 10 80) 
then
echo "User Declined Squid"
else
sudo apt-get install -y squid3
sudo apt-get install -y squidguard
sudo echo "squidfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
