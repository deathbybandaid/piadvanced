#!/bin/sh
## Dark Pi-Hole Theme

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Dark webui theme?" 8 78) then
echo "User Declined Dark Theme"
else
sudo wget https://raw.githubusercontent.com/lkd70/PiHole-Dark/master/install.sh -P /var/www/html/
cd /var/www/html
sudo bash install.sh
fi }
