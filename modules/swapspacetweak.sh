#!/bin/sh
## Tweak to increase swap space
NAMEOFAPP="swapspace"
WHATITDOES="This will set your swapspace size."

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
NEW_SWAP=$(whiptail --inputbox "What do you want your swap space to be?" 10 80 "100" 3>&1 1>&2 2>&3)
sudo sed -i '/CONF_SWAPSIZE/d' /etc/dphys-swapfile
sudo echo "CONF_SWAPSIZE=$NEW_SWAP" | sudo tee --append /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
