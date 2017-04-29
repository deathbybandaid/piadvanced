#!/bin/sh
## Guacamole
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Guacamole?" 8 78) then
echo "User Declined Guacamole"
else
sudo dos2unix /etc/piadvanced/installscripts/guacamole.sh
sudo bash /etc/piadvanced/installscripts/guacamole.sh
sudo echo "guacamolefirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
