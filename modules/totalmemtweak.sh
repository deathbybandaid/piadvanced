#!/bin/sh
## This is an experimental tweak to unlock the pi's missing 16MB
NAMEOFAPP="ramtweak"
WHATITDOES="This is an experimental tweak for the pi2 and pi3 to unlock an extra 16MB of ram."

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
NEWMEM_UNLOCK=$(whiptail --inputbox "Setting to 1024 is the Maximum. It may be prudent to say 1023" 10 80 "1023" 3>&1 1>&2 2>&3)
sudo sed -i '/total_mem/ d' /boot/config.txt
sudo echo "total_mem=$NEWMEM_UNLOCK" | sudo tee --append /boot/config.txt

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
