#!/bin/sh
## pihole tweaks
NAMEOFAPP="piholetweaks"
WHATITDOES="These are tweaks to go alongside Pi-Hole."

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 8 78) 
then
echo "$CURRENTUSER Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=no" | sudo tee --append /etc/piadvanced/install/variables.conf
else
echo "$CURRENTUSER Accepted $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=yes" | sudo tee --append /etc/piadvanced/install/variables.conf

## Below here is the magic.
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
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-chadmayfieldpornblock.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-notracking
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-tweeter.sh
sudo bash /etc/piadvanced/modules/piholetweakmodules/pihole-email.sh

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
