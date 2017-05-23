#!/bin/sh
## Plexboard
NAMEOFAPP="plexboard"
WHATITDOES="A dynamic dashboard for checking the status of multiple services related to Plex Media Server."

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
sudo wget https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer -P /etc/piadvanced/installscripts/
sudo bash /etc/piadvanced/installscripts/rvm-installer
source /home/pi/.rvm/scripts/rvm
rvm requirements
sudo chmod 777 /opt -R && cd /opt
git clone https://github.com/scytherswings/Plex-Board.git && cd /opt/Plex-Board
rvm install 2.3.4 && rvm use 2.3.4@plexdashboard --create
./serverSetup.sh
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
