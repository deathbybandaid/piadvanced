#!/bin/sh
## youtube adblocker

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Youtube adlocking" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use an script to add additional youtube adblocking?" 10 80) 
then
echo "User Declined the youtube ad blocker"
else
sudo pip install -r /etc/piadvanced/piholetweaks/youtubeadblock/requirements.txt
(crontab -l ; echo "0 2 * * * sudo bash /etc/piadvanced/piholetweaks/youtubeadblock/youtube-ads.sh") | crontab -
sudo echo "#http://localhost/admin/youtube.txt" | sudo tee --append /etc/pihole/adlists.list
fi }
