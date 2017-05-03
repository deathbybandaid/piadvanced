#!/bin/sh
#rpimonitor
NAMEOFAPP="rpimonitor"

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
sudo wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list
sudo apt-get install -y rpimonitor
sudo /etc/init.d/rpimonitor update
sudo sed -i "s/#daemon.port=8889/daemon.port=8889/" /etc/rpimonitor/daemon.conf
sudo service rpimonitor restart
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }

unset NAMEOFAPP
