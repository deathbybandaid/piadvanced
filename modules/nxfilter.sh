#!/bin/sh
## nxfilter
NAMEOFAPP="nxfilter"
WHATITDOES="Fast, Light, Powerful DNS Filter."

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
NXFILTERIP=$(whiptail --inputbox "Please enter an IP address to listen on." 10 80 "0.0.0.0" 3>&1 1>&2 2>&3)
NXFILTERA=$(whiptail --inputbox "Please enter a port for http" 10 80 "80" 3>&1 1>&2 2>&3)
NXFILTERB=$(whiptail --inputbox "Please enter a port for https" 10 80 "443" 3>&1 1>&2 2>&3)
sudo wget http://nxfilter.org/download/nxfilter-3.3.4.zip -P /etc/
sudo unzip /etc/nxfilter-3.3.4.zip -d /etc/nxfilter
sudo rm -r /etc/nxfilter-3.3.4.zip
sudo bash /etc/nxfilter/bin/startup.sh
{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to change the dns listen port? dnsmasq/pihole uses 53, dnscrypt uses 5454, 5656, and 5757" 8 78) 
then
NXFILTERC=$(whiptail --inputbox "Please enter alternative dns port." 10 80 "5858" 3>&1 1>&2 2>&3)
sudo echo "dns_port = $NXFILTERC" | sudo tee --append /etc/nxfilter/conf/cfg.properties
fi }
sudo sed -i '/exit 0/d' /etc/rc.local
sudo sed -i '$i /etc/nxfilter/bin/startup.sh -d' /etc/rc.local
sudo sed -i '$i exit 0' /etc/rc.local
sudo sed -i "s/http_port = 80/http_port = $NXFILTERA/" /etc/nxfilter/conf/cfg.properties
sudo sed -i "s/https_port = 443/https_port = $NXFILTERB/" /etc/nxfilter/conf/cfg.properties
sudo sed -i "s/listen_ip = 0.0.0.0/listen_ip = $NXFILTERIP/" /etc/nxfilter/conf/cfg.properties
sudo service nxfilter restart
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
