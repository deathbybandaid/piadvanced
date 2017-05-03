#!/bin/sh
## exim4

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Exim4" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install exim4?" 10 80) 
then
echo "User Declined Exim4"
else
sudo apt-get install -y exim4 
sudo dpkg-reconfigure exim4-config
fi }
