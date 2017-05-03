#!/bin/sh
## DNSMasq
NAMEOFAPP="dnsmasq"

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
{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Regular" --no-button "Experimental" --yesno "Do you want to use the experimental version 2.77test4?" 10 80) 
then
sudo apt-get install -y dnsmasq
else
sudo bash /etc/piadvanced/installscripts/dnsmasqupgrade.sh
fi }
fi }

unset NAMEOFAPP
