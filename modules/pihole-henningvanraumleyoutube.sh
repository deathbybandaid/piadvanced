#!/bin/sh
## youtube henning

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use HenningVanRaumle's youtube adblock list?" 8 78) then
echo "User Declined HenningVanRaumle"
else
sudo echo "#https://raw.githubusercontent.com/HenningVanRaumle/pihole-ytadblock/master/ytadblock.txt" | sudo tee --append /etc/pihole/adlists.list
fi }
