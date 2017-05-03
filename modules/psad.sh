#!/bin/sh
## PSAD
NAMEOFAPP="psad"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install $NAMEOFAPP?" 10 80) 
then
echo "User Declined $NAMEOFAPP"
else
sudo wget http://cipherdyne.org/psad/download/psad-2.4.4.tar.gz -P /etc/piadvanced/installscripts/
sudo tar xzf psad-2.4.4.tar.gz
cd psad-2.4.4
sudo ./install.pl
fi }

unset NAMEOFAPP
