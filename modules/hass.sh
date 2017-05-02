#!/bin/sh
## HASS

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install HASS? This install takes some decent time." 10 80) 
then
echo "User Declined HASS"
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
sudo echo "hassfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
