#!/bin/sh
## HASS
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install HASS?" 8 78) then
echo "User Declined HASS"
else
sudo wget https://raw.githubusercontent.com/home-assistant/fabric-home-assistant/master/hass_rpi_installer.sh -P  /etc/piadvanced/installscripts/
sudo bash /etc/piadvanced/installscripts/hass_rpi_installer.sh
sudo echo "hassfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
