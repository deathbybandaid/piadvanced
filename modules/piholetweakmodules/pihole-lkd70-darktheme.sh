#!/bin/sh
## Dark Pi-Hole Theme
NAMEOFAPP="piholedarktheme"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" -yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Dark webui theme?" 10 80) 
then
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
sudo wget https://raw.githubusercontent.com/lkd70/PiHole-Dark/master/install.sh -P /var/www/html/
cd /var/www/html
sudo bash install.sh
fi }

unset NAMEOFAPP
