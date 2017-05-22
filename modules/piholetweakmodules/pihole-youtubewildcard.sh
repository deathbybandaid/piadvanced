#!/bin/sh
## youtubewildcard
NAMEOFAPP="youtubewildcard"
WHATITDOES="an attempt at blocking youtube ads"

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
PIHOLEIP=$(whiptail --inputbox "Please enter IP of pihole lighttpd" 10 80 "" 3>&1 1>&2 2>&3)
sudo cp /etc/piadvanced/piholetweaks/12-youtubewildcard.conf /etc/dnsmasq.d/
sudo sed -i "s/IPADDRESS/$PIHOLEIP/" /etc/dnsmasq.d/12-youtubewildcard.conf


## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
