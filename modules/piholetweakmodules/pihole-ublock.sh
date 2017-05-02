#!/bin/sh
## Ublock Parser

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want a program to parse additional lists? By default this uses lists used by ublock. To change the lists, edit lists.lst in /etc/piadvanced/installscripts/ublockpihole/" 8 78) then
echo "User Declined the UBlock Parser"
else
sudo cp -n /etc/piadvanced/piholetweaks/ublockpihole/lists.lst.default /etc/piadvanced/piholetweaks/ublockpihole/lists.lst
(crontab -l ; echo "0 1 * * * sudo bash /etc/piadvanced/piholetweaks/ublockpihole/ublockpihole.sh") | crontab -
sudo echo "#http://localhost/admin/ublock.txt" | sudo tee --append /etc/pihole/adlists.list
fi }
