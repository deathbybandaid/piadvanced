#!/bin/sh
## pihole tweaks
NAMEOFAPP="piholetweaks"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Pi-Hole tweaks" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install any Pi-Hole tweaks?" 10 80) 
then
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-wally3kadlists.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-lkd70-darktheme.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-wally3kblockpage.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-deathbybandaid.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-autoupdate.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-gravity.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-ublock.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-youtubeadblock.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-adguard.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-phpparser.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-henningvanraumleyoutube.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-tweeter.sh
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
