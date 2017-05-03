#!/bin/sh
## speedtest.cli

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Speedtest-CLI" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install speedtest cli?" 10 80) 
then



echo "not installing stuff"

else

echo "installing stuff"



fi }
