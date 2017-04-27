#!/bin/sh
## Guacamole
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Guacamole?" 8 78) then
echo "User Declined Guacamole"
else
sudo wget https://raw.githubusercontent.com/MysticRyuujin/guac-install/master/guac-install.sh -P /etc/piadvanced/installscripts/
sudo chmod +x /etc/piadvanced/installscripts/guac-install.sh
sudo apt-get install -y dos2unix
sudo dos2unix /etc/piadvanced/installscripts/guac-install.sh
sudo bash /etc/piadvanced/installscripts/guac-install.sh
sudo echo "guacamolefirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
