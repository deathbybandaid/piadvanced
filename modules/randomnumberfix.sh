#!/bin/sh
## Random Number fix
NAMEOFAPP="rngtools"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "RNG-Tools" --yes-button "Skip" --no-button "Proceed" --yesno "Do you wnat to install the random number fix?" 10 80) 
then
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
sudo apt-get install -y rng-tools
sudo cp /etc/default/rng-tools /etc/piadvanced/backups/
sudo echo 'HRNGDEVICE=/dev/urandom' | sudo tee --append /etc/default/rng-tools
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
