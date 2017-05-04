#!/bin/sh
## SSH
## I might add the option to use a key versus password for login.
NAMEOFAPP="ssh"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Disable" --no-button "Enable" --yesno "Would you like the SSH server enabled or disabled?" 10 80) 
then
update-rc.d ssh disable &&
whiptail --msgbox "SSH server disabled" 10 80 1
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
update-rc.d ssh enable &&
invoke-rc.d ssh start &&
whiptail --msgbox "SSH server enabled" 10 80 1
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
