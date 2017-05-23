#!/bin/sh
## wlan0 setup
NAMEOFAPP="wlan0"
WHATITDOES="This will give your wlan0 interface a static ip address."

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
whiptail --msgbox "Let's set a static IP using wlan0" 10 80 1
OLDWLAN_IP=`ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
OLDWLAN_GATEWAY=`ip route show 0.0.0.0/0 dev wlan0 | cut -d\  -f3`
NEWWLAN_IP=$(whiptail --inputbox "Please enter desired IP for wlan0" 10 80 "$OLDWLAN_IP" 3>&1 1>&2 2>&3)
sudo cp /etc/dhcpcd.conf /etc/piadvanced/backups/dhcpcd.conf
sudo sed -i '/#wlan0/d' /etc/dhcpcd.conf
sudo sed -i '/interface wlan0/d' /etc/dhcpcd.conf
sudo sed -i '/static ip_address=$OLDWLAN_IP/d' /etc/dhcpcd.conf
sudo sed -i '/static routers=$OLDWLAN_GATEWAY/d' /etc/dhcpcd.conf
sudo sed -i '/static domain_name_servers=$OLDWLAN_GATEWAY/d' /etc/dhcpcd.conf
sudo echo "" | sudo tee --append /etc/dhcpcd.conf
sudo echo "#wlan0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "interface wlan0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static ip_address=$NEWWLAN_IP" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static routers=$OLDWLAN_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static domain_name_servers=$OLDWLAN_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
sudo ifconfig wlan0 $NEWWLAN_IP

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
