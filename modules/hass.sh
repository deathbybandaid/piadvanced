#!/bin/sh
## HASS
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install HASS? This install takes some decent time." 8 78) then
echo "User Declined HASS"
else
curl -O https://raw.githubusercontent.com/home-assistant/fabric-home-assistant/master/hass_rpi_installer.sh && sudo chown pi:pi hass_rpi_installer.sh && bash hass_rpi_installer.sh
#sudo wget https://raw.githubusercontent.com/home-assistant/fabric-home-assistant/master/hass_rpi_installer.sh -P  /etc/piadvanced/installscripts/
#{ if [ "$CHANGED_USERNAME" = "yes" ]
#then
#sudo chown $NEW_USERNAME:$NEW_USERNAME /etc/piadvanced/installscripts/hass_rpi_installer.sh
#else
#sudo chown pi:pi /etc/piadvanced/installscripts/hass_rpi_installer.sh
#fi }
#bash /etc/piadvanced/installscripts/hass_rpi_installer.sh
sudo echo "hassfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
