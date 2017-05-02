#!/bin/sh
## nagios

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install nagios?" 10 80) 
then



echo "not installing stuff"

else

echo "installing stuff"



fi }
