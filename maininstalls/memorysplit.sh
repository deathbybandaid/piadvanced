#!/bin/sh
## This sets the memory split.
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to set the memory split" 8 78) then
sudo sed -i '/total_mem/ d' /boot/config.txt
else
NEWMEM_SPLIT=$(whiptail --inputbox "Do you plan on running headless? If so, set the memory split to 16." 20 60 "16" 3>&1 1>&2 2>&3)
sudo cp /boot/config.txt /etc/piadvanced/backups/boot/
sudo sed -i '/gpu_mem/ d' /boot/config.txt
sudo echo "gpu_mem=$NEWMEM_SPLIT" | sudo tee --append /boot/config.txt
fi }

## This is an experimental tweak to unlock the pi's missing 16MB
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to try the experimental unlock of an extra 16MB. This is for the Pi2 and Pi3 only" 8 78) then
sudo sed -i '/total_mem/ d' /boot/config.txt
else
NEWMEM_UNLOCK=$(whiptail --inputbox "Setting to 1024 is the Maximum. It may be prudent to say 1023" 20 60 "1023" 3>&1 1>&2 2>&3)
sudo sed -i '/total_mem/ d' /boot/config.txt
sudo echo "total_mem=$NEWMEM_UNLOCK" | sudo tee --append /boot/config.txt
fi }
