#!/bin/sh
## wifi setup
NAMEOFAPP="wifi"
WHATITDOES="This will help you connect to wifi"

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
NEW_SSID=$(whiptail --inputbox "Please enter SSID" 10 80 "" 3>&1 1>&2 2>&3)
NEW_PSK=$(whiptail --inputbox "Please enter wifi password" 10 80 "" 3>&1 1>&2 2>&3)
sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/piadvanced/backups/
sudo echo "NEWWLAN_IP=$NEWWLAN_IP" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "NEW_SSID=$NEW_SSID" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "NEW_PSK=$NEW_PSK" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "## Wifi" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "network={"| sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "    ssid=""$NEW_SSID""" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "    psk=""$NEW_PSK""" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "}" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
