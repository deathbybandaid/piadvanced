#!/bin/sh
## Updates

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Updates" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to run updates?" 10 80) 
then
echo "User Declined Updating"
else
sudo apt-get -y update --fix-missing
sudo apt-get -y dist-upgrade -alow-downgrades
sudo apt-get autoremove-y 
sudo apt-get clean
fi }
