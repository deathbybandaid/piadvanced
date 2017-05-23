#!/bin/sh
## Random Number fix
NAMEOFAPP="rngtools"
WHATITDOES="The rng-tools is a set of utilities related to random number generation in kernel."

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
sudo apt-get install -y rng-tools
sudo cp /etc/default/rng-tools /etc/piadvanced/backups/
sudo echo 'HRNGDEVICE=/dev/urandom' | sudo tee --append /etc/default/rng-tools

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
