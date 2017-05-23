#!/bin/sh
## Apache
NAMEOFAPP="apache"
WHATITDOES="This is one of the most common webservers."

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
whiptail --msgbox "What ports do you want Apache to use?" 10 80 1
NEW_APACHE80=$(whiptail --inputbox "Change the default port 80 for Apache" 10 80 "85" 3>&1 1>&2 2>&3)
NEW_APACHE443=$(whiptail --inputbox "Change the default port 443 for Apache" 10 80 "445" 3>&1 1>&2 2>&3)
sudo apt-get install -y apache2
sudo cp -r /etc/apache2/ /etc/piadvanced/backups/apache2/
sudo echo "NEW_APACHE80=$NEW_APACHE80" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "NEW_APACHE443=$NEW_APACHE443" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo sed -i "s/80/$NEW_APACHE80/" /etc/apache2/ports.conf
sudo sed -i "s/80/$NEW_APACHE80/" /etc/apache2/sites-enabled/000-default.conf
sudo sed -i "s/443/$NEW_APACHE443/" /etc/apache2/ports.conf
sudo sed -i "s/443/$NEW_APACHE443/" /etc/apache2/sites-enabled/000-default.conf

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
