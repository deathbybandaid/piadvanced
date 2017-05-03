#!/bin/sh
## PSAD

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "PSAD" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install psad?" 10 80) 
then
echo "User Declined PSAD"
else
sudo wget http://cipherdyne.org/psad/download/psad-2.4.4.tar.gz -P /etc/piadvanced/installscripts/
sudo tar xzf psad-2.4.4.tar.gz
cd psad-2.4.4
sudo ./install.pl
fi }
