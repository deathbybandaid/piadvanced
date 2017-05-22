#!/bin/sh
## This script will replace the user pi.

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Simple test if Whiptail is installed. 
{ if
which whiptail >/dev/null;
then
:
else
sudo apt-get install -y whiptail
fi }

## Ask if Root, If Not exits
{ if 
(whiptail --title "Remove User pi" --yes-button "I am Not Root" --no-button "I am Root" --yesno "Are you running as root?" 10 80)
then
echo "User Not Root"
echo "Exiting"
exit
else
echo "Let's rename the user pi. This will make the pi a great deal more secure. I will ask you for a username and a password." > changepi_textbox
whiptail --textbox --title "Information" changepi_textbox 10 80
NEW_USERNAME=$(whiptail --title "New Username" --inputbox "Please enter desired username, you will then be prompted to create a new password" 10 80 "" 3>&1 1>&2 2>&3)
usermod -l $NEW_USERNAME -m -d /home/$NEW__USERNAME pi
groupmod -n $NEW_USERNAME pi
sudo passwd $NEW_USERNAME
sudo echo "NEW_USERNAME=$NEW_USERNAME" | sudo tee --append /etc/piadvanced/install/userchange.conf
sudo echo "CHANGED_USERNAME=yes" | sudo tee --append /etc/piadvanced/install/userchange.conf
echo "pi has been replaced by $NEW_USERNAME"
fi }
