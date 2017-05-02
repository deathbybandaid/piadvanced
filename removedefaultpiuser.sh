#!/bin/sh
## This script will replace the user pi.

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

## Ask if Root, If Not exits
{ if 
(whiptail --title "Remove User pi" --yes-button "I am Not Root" --no-button "I am Root" --yesno "Are you running as root?" 8 78)
then
echo "User Not Root"
echo "Exiting"
exit
else
whiptail -msgbox --title "Information" "
Let's rename the user pi.
This will make the pi a great deal more secure.
I will ask you for a username and a password.
" 20 70 1
NEW_USERNAME=$(whiptail --title "New Username" --inputbox "Please enter desired username, you will then be prompted to create a new password" 20 60 "" 3>&1 1>&2 2>&3)
usermod -l $NEW_USERNAME -m -d /home/$NEW__USERNAME pi
groupmod -n $NEW_USERNAME pi
sudo passwd $NEW_USERNAME
sudo echo "NEW_USERNAME=$NEW_USERNAME" | sudo tee --append /etc/piadvanced/install/userchange.conf
sudo echo "CHANGED_USERNAME=yes" | sudo tee --append /etc/piadvanced/install/userchange.conf
echo "pi has been replaced by $NEW_USERNAME"
fi }
