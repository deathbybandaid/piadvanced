#!/bin/sh
## This is an experimental tweak to unlock the pi's missing 16MB
NAMEOFAPP="ramtweak"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Ram Tweak" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to try the experimental unlock of an extra 16MB. This is for the Pi2 and Pi3 only" 10 80) 
then
sudo sed -i '/total_mem/ d' /boot/config.txt
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
NEWMEM_UNLOCK=$(whiptail --inputbox "Setting to 1024 is the Maximum. It may be prudent to say 1023" 10 80 "1023" 3>&1 1>&2 2>&3)
sudo sed -i '/total_mem/ d' /boot/config.txt
sudo echo "total_mem=$NEWMEM_UNLOCK" | sudo tee --append /boot/config.txt
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
