#!/bin/sh
## HASS
NAMEOFAPP="hass"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install $NAMEOFAPP ?" 10 80) 
then
echo "User Declined $NAMEOFAPP"
else
#sudo wget https://raw.githubusercontent.com/home-assistant/fabric-home-assistant/master/hass_rpi_installer.sh -P  /etc/piadvanced/installscripts/
#{ if [ "$CHANGED_USERNAME" = "yes" ]
#then
#sudo chown $NEW_USERNAME:$NEW_USERNAME /etc/piadvanced/installscripts/hass_rpi_installer.sh
#else
#sudo chown pi:pi /etc/piadvanced/installscripts/hass_rpi_installer.sh
#fi }
#bash /etc/piadvanced/installscripts/hass_rpi_installer.sh
sudo bash /etc/piadvanced/installscripts/hassinstall.sh
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }

unset NAMEOFAPP
