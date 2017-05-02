#!/bin/sh
## Wally3kadlists

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Wally3k adlists.list" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install the Wally3k adlists.list?" 10 80) 
then
echo "User Declined Wally3k's adlists.list"
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/wally3k-adlists.list/master/adlists.list -P /etc/pihole/
fi }
