#!/bin/sh
## duckdns
NAMEOFAPP="duckdns"
WHATITDOES="This will help keep your DuckDNS address."

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
DUCKDNSDOMAIN=$(whiptail --inputbox "What is your DuckDNS Domain Name?" 10 80 "" 3>&1 1>&2 2>&3)
DUCKDNSTOKEN=$(whiptail --inputbox "What is your DuckDNS Token?" 10 80 "" 3>&1 1>&2 2>&3)
cp -n /etc/piadvanced/installscripts/duckdnsscript.sh.default /etc/piadvanced/installscripts/duckdnsscript.sh
sudo sed -i "s/DUCKDOMAIN/$DUCKDNSDOMAIN/" /etc/piadvanced/installscripts/duckdnsscript.sh
sudo sed -i "s/TOKENVALUE/$DUCKDNSTOKEN/" /etc/piadvanced/installscripts/duckdnsscript.sh
(crontab -l ; echo "## DuckDNS Update") | crontab -
(crontab -l ; echo "*/5 * * * * /etc/piadvanced/installscripts/duckdnsscript.sh >/dev/null 2>&1") | crontab -
(crontab -l ; echo "") | crontab -
## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
