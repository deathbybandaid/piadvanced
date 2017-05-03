#!/bin/sh
## duckdns

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "DuckDNS" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install duckdns?" 10 80) 
then
echo "User Declined duckdns"
else



fi }
