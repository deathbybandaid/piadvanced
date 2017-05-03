#!/bin/sh
## raspcontrol

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "RaspControl" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install raspcontrol?" 10 80) 
then



echo "not installing stuff"

else

echo "installing stuff"



fi }
