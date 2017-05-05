#!/bin/sh
## pihole
NAMEOFAPP="pihole"
WHATITDOES="A black hole for Internet advertisements."

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
git clone --depth 1 https://github.com/pi-hole/pi-hole.git /etc/piadvanced/installscripts/Pi-hole
cd /etc/piadvanced/installscripts/Pi-hole/automated\ install/
bash basic-install.sh
whiptail --msgbox "Let's change pihole password" 10 80 1
NEW_PASS=$(whiptail --inputbox "Please enter a password" 10 80 "" 3>&1 1>&2 2>&3)
pihole -a -p $NEW_PASS
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
sudo bash /etc/piadvanced/modules/pihole-tweaks.sh

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
