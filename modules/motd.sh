#!/bin/sh
## Message of the day
NAMEOFAPP="motd"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to Change your message of the day to a much cooler one?" 10 80) 
then
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
whiptail --msgbox "This is the message you receive at login" 10 80 1
sudo systemctl disable motd
sudo mkdir /etc/update-motd.d
sudo rm -f /etc/motd
sudo cp /etc/piadvanced/installscripts/pimotd/10logo /etc/update-motd.d/
sudo chmod a+x /etc/update-motd.d/*
sudo sed -i "s/motd.dynamic/motd.new/" /etc/pam.d/sshd
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
