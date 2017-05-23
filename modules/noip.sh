#!/bin/sh
## No-IP
NAMEOFAPP="noipduc"
WHATITDOES="This is the Dynamic Update Client for NoIp"

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
sudo mkdir /home/installs/noip
sudo wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz -P /etc/piadvanced/installscripts/noip/
cd /etc/piadvanced/installscripts/noip/
sudo tar vzxf noip-duc-linux.tar.gz
cd /etc/piadvanced/installscripts/noip/noip-2.1.9-1/
sudo make
sudo make install
sudo /usr/local/bin/noip2
sudo noip2 ­-S

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
