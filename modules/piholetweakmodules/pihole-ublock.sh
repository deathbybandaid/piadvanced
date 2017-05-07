#!/bin/sh
## Ublock Parser
NAMEOFAPP="piholeublockparser"
WHATITDOES="This is a parser for the lists used by Ublock"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 8 78) 
then
echo "$CURRENTUSER Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=no" | sudo tee --append /etc/piadvanced/install/variables.conf
else
echo "$CURRENTUSER Accepted $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=yes" | sudo tee --append /etc/piadvanced/install/variables.conf

## Below here is the magic.
sudo cp -n /etc/piadvanced/piholetweaks/ublockpihole/lists.lst.default /etc/piadvanced/piholetweaks/ublockpihole/lists.lst
(crontab -l ; echo "## UblockPihole") | crontab -
(crontab -l ; echo "0 1 * * * sudo bash /etc/piadvanced/piholetweaks/ublockpihole/ublockpihole.sh") | crontab -
(crontab -l ; echo "") | crontab -
sudo echo "## Ublock Pihole" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/admin/ublock.txt" | sudo tee --append /etc/pihole/adlists.list

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
