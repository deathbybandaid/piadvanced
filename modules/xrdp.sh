#!/bin/sh
## XRDP

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install xrdp?" 10 80) 
then
echo "User Declined xrdp"
else
sudo apt-get install -y xrdp
sudo echo "xrdpfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
