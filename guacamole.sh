#!/bin/sh
## Guacamole
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Guacamole?" 8 78) then
echo "User Declined Guacamole"
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/piguac/master/guac.sh -P /etc/piadvanced/installscripts/
sudo chmod +x /etc/piadvanced/installscripts/guac.sh
sudo dos2unix /etc/piadvanced/installscripts/guac.sh
sudo bash /etc/piadvanced/installscripts/guac.sh
sudo echo "guacamolefirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
