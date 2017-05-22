#!/bin/sh
## piholeextendedhosts
NAMEOFAPP="piholeextendedhosts" # This helps set the name of your app throught the module.
WHATITDOES="similar to running Ublock and Ghostery on a computer"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables (if in every file, an installer can be re-run independently)
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
cd /etc/piadvanced/piholetweaks/pihole-extended-hosts/
git clone git://github.com/StevenBlack/hosts /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist/
mkdir -p /etc/piadvanced/piholetweaks/pihole-extended-hosts/custom.hosts
sudo bash /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-update.sh
(crontab -l ; echo "## piholeextendedhosts") | crontab -
(crontab -l ; echo "0 1 * * * sudo bash /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-update.sh") | crontab -
(crontab -l ; echo "") | crontab -
sudo echo "## piholeextendedhosts" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/extended.txt" | sudo tee --append /etc/pihole/adlists.list

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
## credit goes to benlowry
