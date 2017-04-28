#!/bin/sh
git clone --depth 1 https://github.com/pi-hole/pi-hole.git /etc/piadvanced/installscripts/Pi-hole
cd /etc/piadvanced/installscripts/Pi-hole/automated\ install/
bash basic-install.sh
whiptail --msgbox "Let's change pihole password" 20 70 1
NEW_PASS=$(whiptail --inputbox "Please enter a password" 20 60 "" 3>&1 1>&2 2>&3)
pihole -a -p $NEW_PASS
