#!/bin/sh
## hostname settings
NAMEOFAPP="hostname"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want set the hostname?" 10 80) 
then
echo "User Declined setting a new hostname"
else
OLD_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
NEW_HOSTNAME=$(whiptail --inputbox "Please enter a hostname" 20 60 "$OLD_HOSTNAME" 3>&1 1>&2 2>&3)
sudo cp /etc/hosts /etc/piadvanced/backups/hostname/
sudo cp /etc/hostname /etc/piadvanced/backups/hostname/
sudo echo "NEW_HOSTNAME=$NEW_HOSTNAME" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "$NEW_HOSTNAME" > /etc/hostname
sudo sed -i "s/127.0.1.1.*$OLD_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
fi }

unset NAMEOFAPP
