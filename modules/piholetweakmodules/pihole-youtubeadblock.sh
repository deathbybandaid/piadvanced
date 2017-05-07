#!/bin/sh
## youtube adblocker
NAMEOFAPP="youtubeadblocker"
WHATITDOES="This is a parser to help blcok Youtube ads."

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
sudo pip install -r /etc/piadvanced/piholetweaks/youtubeadblock/requirements.txt
(crontab -l ; echo "## Pihole Youtube Blocking") | crontab -
(crontab -l ; echo "0 2 * * * sudo bash /etc/piadvanced/piholetweaks/youtubeadblock/youtube-ads.sh") | crontab -
(crontab -l ; echo "") | crontab -
sudo echo "Youtube Parser" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/admin/youtube.txt" | sudo tee --append /etc/pihole/adlists.list

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
