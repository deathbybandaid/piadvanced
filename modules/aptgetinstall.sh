#!/bin/sh
## Dependencies
NAMEOFAPP="dependencies"
WHATITDOES="These are programs that are a foundation for other softwares. Skipping could be fatal."

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
sudo bash /etc/piadvanced/dependencies/basics.sh
sudo bash /etc/piadvanced/dependencies/python.sh
sudo bash /etc/piadvanced/dependencies/libraries.sh
sudo bash /etc/piadvanced/dependencies/php.sh
sudo bash /etc/piadvanced/dependencies/net-tools.sh
sudo bash /etc/piadvanced/dependencies/mysql.sh

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
