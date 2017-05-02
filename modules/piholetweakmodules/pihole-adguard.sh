#!/bin/sh
## adguard blocking

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use a script to add adguard blocking?" 8 78) then
echo "User Declined adguard parser"
else
(crontab -l ; echo "0 3 * * * sudo bash /etc/piadvanced/piholetweaks/adguard.sh") | crontab -
sudo echo "#http://localhost/admin/adguard.txt" | sudo tee --append /etc/pihole/adlists.list
fi }
