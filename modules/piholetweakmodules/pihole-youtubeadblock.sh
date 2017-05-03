#!/bin/sh
## youtube adblocker
NAMEOFAPP="youtubeadblocker"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install $NAMEOFAPP?" 10 80) 
then
echo "User Declined $NAMEOFAPP"
else
sudo pip install -r /etc/piadvanced/piholetweaks/youtubeadblock/requirements.txt
(crontab -l ; echo "0 2 * * * sudo bash /etc/piadvanced/piholetweaks/youtubeadblock/youtube-ads.sh") | crontab -
sudo echo "#http://localhost/admin/youtube.txt" | sudo tee --append /etc/pihole/adlists.list
fi }

unset NAMEOFAPP
