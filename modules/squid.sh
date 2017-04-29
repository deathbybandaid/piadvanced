#!/bin/sh
## Squid
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Squid and Squidguard?" 8 78) then
echo "User Declined Squid"
else
sudo apt-get install -y squid3
sudo apt-get install -y squidguard
sudo echo "squidfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
