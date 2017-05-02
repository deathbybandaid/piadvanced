#!/bin/sh
## This is an experimental tweak to unlock the pi's missing 16MB

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to try the experimental unlock of an extra 16MB. This is for the Pi2 and Pi3 only" 10 80) 
then
sudo sed -i '/total_mem/ d' /boot/config.txt
else
NEWMEM_UNLOCK=$(whiptail --inputbox "Setting to 1024 is the Maximum. It may be prudent to say 1023" 10 80 "1023" 3>&1 1>&2 2>&3)
sudo sed -i '/total_mem/ d' /boot/config.txt
sudo echo "total_mem=$NEWMEM_UNLOCK" | sudo tee --append /boot/config.txt
fi }
