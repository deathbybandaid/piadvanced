#!/bin/sh
## Privoxy

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Privoxy" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Privoxy?" 10 80) 
then
echo "User Declined Privoxy"
else
sudo apt-get install -y privoxy
sudo echo "privoxyfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
