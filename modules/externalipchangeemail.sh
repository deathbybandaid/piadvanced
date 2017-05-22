#!/bin/sh
## externalipchangeemail
NAMEOFAPP="externalipchangeemail" # This helps set the name of your app throught the module.
WHATITDOES="Get an email when your external IP address changes"

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
IPADDRESSEMAIL=$(whiptail --inputbox "Please enter email address" 10 80 "" 3>&1 1>&2 2>&3)
sudo echo "EMAIL=$IPADDRESSEMAIL" | sudo tee --append /etc/piadvanced/installscripts/externalipemail/email.var
(crontab -l ; echo "## IP change Email") | crontab -
(crontab -l ; echo "0 */6 * * * sudo bash /etc/piadvanced/installscripts/externalipemail/checkip.sh") | crontab -
(crontab -l ; echo "") | crontab -



## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
