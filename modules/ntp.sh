#!/bin/sh
## NTP
NAMEOFAPP="ntp"
WHATITDOES="This will help you set the NTP servers that your device uses."

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
NEW_NTP=$(whiptail --inputbox "Set server here" 10 80 "debian.pool.ntp.org" 3>&1 1>&2 2>&3)
sudo cp /etc/ntp.conf /etc/piadvanced/backups/
sudo sed -i "s/pool 0.debian.pool.ntp.org iburst/pool 0.$NEW_NTP iburst/" /etc/ntp.conf
sudo sed -i "s/pool 1.debian.pool.ntp.org iburst/pool 1.$NEW_NTP iburst/" /etc/ntp.conf
sudo sed -i "s/pool 2.debian.pool.ntp.org iburst/pool 2.$NEW_NTP iburst/" /etc/ntp.conf
sudo sed -i "s/pool 3.debian.pool.ntp.org iburst/pool 3.$NEW_NTP iburst/" /etc/ntp.conf
sudo service ntp stop
sudo ntpd -gq
sudo service ntp start

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
