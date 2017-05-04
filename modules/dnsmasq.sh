#!/bin/sh
## DNSMasq
NAMEOFAPP="dnsmasq"
WHATITDOES="DNSmasq is a DNS resolver. It is what Pi-hole uses for DNS and DHCP."

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
{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Regular" --no-button "Experimental" --yesno "Do you want to use the experimental version 2.77test4?" 10 80) 
then
sudo apt-get install -y dnsmasq
else
sudo bash /etc/piadvanced/installscripts/dnsmasqupgrade.sh
fi }

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
