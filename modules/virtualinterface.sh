#!/bin/sh
## vlan
NAMEOFAPP="vlan" # This helps set the name of your app throught the module.
WHATITDOES="This let's you have a second IP address on your ehernet interface."

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables (if in every file, an installer can be re-run independently)
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
NEWVLAN_IP=$(whiptail --inputbox "Please enter desired IP for eth0.1" 20 60 "$OLDETH_IP" 3>&1 1>&2 2>&3)
sudo echo "" | sudo tee --append /etc/network/interfaces
sudo echo "# VLAN x Interface" | sudo tee --append /etc/network/interfaces
sudo echo "auto eth0.1" | sudo tee --append /etc/network/interfaces
sudo echo "iface eth0.1 inet manual" | sudo tee --append /etc/network/interfaces
sudo echo "    vlan-raw-device eth0" | sudo tee --append /etc/network/interfaces

sudo echo "" | sudo tee --append /etc/dhcpcd.conf
sudo echo "# Static IP configuration VLan" | sudo tee --append /etc/dhcpcd.conf
sudo echo "interface eth0.1" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static ip_address=$NEWVLAN_IP" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static routers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static domain_name_servers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
