#!/bin/sh
## pihole stalelist fix

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Stale List Fix" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want a script to keep cached lists from becoming stale?" 10 80) 
then
echo "User Declined Stale List Fix"
else
(crontab -l ; echo "0 5 * * 1 sudo bash /etc/piadvanced/piholetweaks/piholefreshlists.sh") | crontab -
fi }
