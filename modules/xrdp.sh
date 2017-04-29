#!/bin/sh
## XRDP
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install xrdp?" 8 78) then
echo "User Declined xrdp"
else
sudo apt-get install -y xrdp
sudo echo "xrdpfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
