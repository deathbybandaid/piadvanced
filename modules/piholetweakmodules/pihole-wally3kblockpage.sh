#!/bin/sh
## Wally3k Block Page

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install the wally3k block page?" 10 80) 
then
echo "User Declined using Wally3k's Block Page"
else
sudo bash /etc/piadvanced/piholetweaks/Wally3kBlockPage.sh
fi }
