#!/bin/sh
## pihole stalelist fix
NAMEOFAPP="piholestalelistfix"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want a script to keep cached lists from becoming stale?" 10 80) 
then
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
(crontab -l ; echo "0 5 * * 1 sudo bash /etc/piadvanced/piholetweaks/piholefreshlists.sh") | crontab -
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
