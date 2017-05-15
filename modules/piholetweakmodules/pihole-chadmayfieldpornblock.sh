#!/bin/sh
## youtube henning
NAMEOFAPP="ChadMayfield Porn Blocklist"
WHATITDOES="This is a block list from Chad Mayfield that helps block pornography."

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 10 80) 
then
echo "$CURRENTUSER Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=no" | sudo tee --append /etc/piadvanced/install/variables.conf
else
echo "$CURRENTUSER Accepted $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=yes" | sudo tee --append /etc/piadvanced/install/variables.conf

## Below here is the magic.
{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "HeavyList" --no-button "LightList" --yesno "Which version of the list?" 10 80) 
then
sudo echo "## ChadMayfield Heavy Porn Blocklist" | sudo tee --append /etc/pihole/adlists.list
sudo echo "https://raw.githubusercontent.com/chadmayfield/pihole-blocklists/master/lists/pi_blocklist_porn_all.list" | sudo tee --append /etc/pihole/adlists.list
else
sudo echo "## ChadMayfield Light Porn Blocklist" | sudo tee --append /etc/pihole/adlists.list
sudo echo "https://raw.githubusercontent.com/chadmayfield/pihole-blocklists/master/lists/pi_blocklist_porn_top1m.list" | sudo tee --append /etc/pihole/adlists.list
fi }
## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
