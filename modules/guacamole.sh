#!/bin/sh
## Guacamole

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Guacamole" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Guacamole?" 10 80) 
then
echo "User Declined Guacamole"
else
sudo dos2unix /etc/piadvanced/installscripts/guacamole.sh
sudo bash /etc/piadvanced/installscripts/guacamole.sh
sudo echo "guacamolefirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
