#!/bin/sh
## Privoxy
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Privoxy?" 8 78) then
echo "User Declined Privoxy"
else
sudo apt-get install -y privoxy
sudo echo "privoxyfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
