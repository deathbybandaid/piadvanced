#!/bin/sh
## Deathbybandaid dnsmasq tweaks
NAMEOFAPP="deathbybandaiddnstweaks"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install $NAMEOFAPP?" 8 78) 
then
echo "User Declined $NAMEOFAPP"
else
sudo cp -n /etc/piadvanced/piholetweaks/dnsmasqtweaks/*.conf /etc/dnsmasq.d/
fi }

unset NAMEOFAPP
