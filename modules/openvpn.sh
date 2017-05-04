#!/bin/sh
## OpenVPN
NAMEOFAPP="openvpn"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you plan on using $NAMEOFAPP ?" 10 80) 
then
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
whiptail --msgbox "Select TCP during the install" 10 80 1
sudo wget https://raw.githubusercontent.com/Nyr/openvpn-install/master/openvpn-install.sh -P /etc/piadvanced/installscripts/
sudo chmod +x /etc/piadvanced/installscripts/openvpn-install.sh
sudo bash /etc/piadvanced/installscripts/openvpn-install.sh
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
sudo sed -i "s/push "dhcp-option DNS 8.8.8.8"/"dhcp-option DNS 10.8.0.1"/" /etc/openvpn/server.conf
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
