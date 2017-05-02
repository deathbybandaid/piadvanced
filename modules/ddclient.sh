#!/bin/sh
## ddclient

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install ddclient?" 8 78) then
echo "User Declined ddclient"
else
sudo apt-get install -y ddclient
sudo echo "pivpnfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
