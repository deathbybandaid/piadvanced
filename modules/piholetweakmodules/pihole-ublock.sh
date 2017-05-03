#!/bin/sh
## Ublock Parser
NAMEOFAPP="piholeublockparser"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want the $NAMEOFAPP?" 10 80) 
then
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
sudo cp -n /etc/piadvanced/piholetweaks/ublockpihole/lists.lst.default /etc/piadvanced/piholetweaks/ublockpihole/lists.lst
(crontab -l ; echo "0 1 * * * sudo bash /etc/piadvanced/piholetweaks/ublockpihole/ublockpihole.sh") | crontab -
sudo echo "#http://localhost/admin/ublock.txt" | sudo tee --append /etc/pihole/adlists.list
fi }

unset NAMEOFAPP
