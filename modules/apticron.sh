#!/bin/sh
## Apticron
NAMEOFAPP="Apticron"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install $NAMEOFAPP ?" 10 80) 
then
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
APTICRON_EMAIL=$(whiptail --inputbox "What email address do you want to use?" 10 80 "user@domain.net" 3>&1 1>&2 2>&3)
sudo apt-get install apticron
sudo sed -i "s/EMAIL="root"/EMAIL="$APTICRON_EMAIL"/" /etc/apticron/apticron.conf
fi }

unset NAMEOFAPP
