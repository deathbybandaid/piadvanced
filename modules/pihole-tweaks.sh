#!/bin/sh
## pihole tweaks

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install any Pi-Hole tweaks?" 8 78) then
echo "User Declined Dark Pi-Hole Tweaks"
else
sudo bash /etc/piadvanced/modules/pihole-wally3kadlists.sh
sudo bash /etc/piadvanced/modules/pihole-lkd70-darktheme.sh
sudo bash /etc/piadvanced/modules/pihole-wally3kblockpage.sh
sudo bash /etc/piadvanced/modules/pihole-deathbybandaid.sh
sudo bash /etc/piadvanced/modules/pihole-autoupdate.sh
sudo bash /etc/piadvanced/modules/pihole-gravity.sh
sudo bash /etc/piadvanced/modules/pihole-ublock.sh
sudo bash /etc/piadvanced/modules/pihole-youtubeadblock.sh
sudo bash /etc/piadvanced/modules/pihole-adguard.sh
sudo bash /etc/piadvanced/modules/pihole-phpparser.sh
sudo bash /etc/piadvanced/modules/pihole-henningvanraumleyoutube.sh
sudo bash /etc/piadvanced/modules/pihole-tweeter.sh
fi }
