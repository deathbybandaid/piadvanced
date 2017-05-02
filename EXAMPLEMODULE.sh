#!/bin/sh
## NAMEOFAPP

## Variables (if in every file, an installer can be re-run independently)
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install ?" 8 78) 
then
echo "User Declined NAMEOFAPP"

else
## Need a message box?
whiptail --msgbox "NAMEOFAPP messagebox" 20 70 1

## Set a variable with a text box?
NEW_VARIABLE=$(whiptail --inputbox "NAMEOFAPP what do you want to type?" 20 60 "NAMEOFAPP suggested text" 3>&1 1>&2 2>&3)


echo "installing stuff"

## Execute install script
sudo bash /etc/piadvanced/installscripts/NAMEOFAPP.sh

## If Firewall rule is needed
sudo echo "NAMEOFAPPfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf

## Save variable to the conf
sudo echo "NEW_VARIABLE=$NEW_VARIABLE" | sudo tee --append /etc/piadvanced/install/variables.conf
fi }
