#!/bin/sh
## pihole autoupdate

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do youw want to run pihole -up every 30 minutes?" 10 80) 
then
echo "User Declined 30 minute autoupdates"
else
(crontab -l ; echo "0,30 * * * * sudo bash /etc/piadvanced/piholetweaks/piholeautoupdate.sh") | crontab -
fi }
