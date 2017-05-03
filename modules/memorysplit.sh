#!/bin/sh
## This sets the memory split.

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Memory Split" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to set the memory split" 10 80) 
then
sudo sed -i '/total_mem/ d' /boot/config.txt
else
NEWMEM_SPLIT=$(whiptail --inputbox "Do you plan on running headless? If so, set the memory split to 16." 10 80 "16" 3>&1 1>&2 2>&3)
sudo cp /boot/config.txt /etc/piadvanced/backups/boot/
sudo sed -i '/gpu_mem/ d' /boot/config.txt
sudo echo "gpu_mem=$NEWMEM_SPLIT" | sudo tee --append /boot/config.txt
fi }
