#!/bin/sh
## ddclient
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install ddclient?" 8 78) then
echo "User Declined ddclient"
else
sudo apt-get install -y ddclient
sudo apt-get remove -y iptables-persistent
sudo echo "pivpnfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
