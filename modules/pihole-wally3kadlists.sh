#!/bin/sh
## Wally3kadlists

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install the Wally3k adlists.list?" 8 78) then
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Would you like to copy adlists.default to adlists.list instead?" 8 78) then
echo "User Declined Using adlists.list"
else
sudo cp /etc/pihole/adlists.default /etc/pihole/adlists.list
fi }
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/wally3k-adlists.list/master/adlists.list -P /etc/pihole/
fi }
