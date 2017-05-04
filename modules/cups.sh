#!/bin/sh
## Cups
NAMEOFAPP="cups"
WHATITDOES="This is probably the best printing server you could have."

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
sudo apt-get install -y cups
{ if 
[ "$CHANGED_USERNAME" = "yes" ]
then
sudo usermod -a -G lpadmin $NEW_USERNAME
else
sudo usermod -a -G lpadmin pi
fi }
sudo sed -i "s/Listen localhost:631/Port 631/" /etc/cups/cupsd.conf
sudo gawk -i inplace '/Order deny,allow/{print;print "Allow from all";next}1' /etc/cups/cupsd.conf
sudo gawk -i inplace '/Order allow,deny/{print;print "Allow from all";next}1' /etc/cups/cupsd.conf
sudo /etc/init.d/cups restart
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
