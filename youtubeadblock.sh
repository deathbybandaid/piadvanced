#!/bin/sh
source /etc/piadvanced/install/variables.conf
## Experimental youtube ad blocking
{ if (whiptail --yesno "Do you want to use an script to add additional adblocking?" 8 78) then
cd /etc/piadvanced/installscripts/
sudo wget https://raw.githubusercontent.com/deathbybandaid/youtubeadblock/master/youtubeadblock.sh
(crontab -l ; echo "0 2 * * * /etc/piadvanced/installscripts/youtubeadblock/youtube-ads.sh") | crontab -
sudo echo "http://localhost/admin/youtube.txt" | sudo tee --append /etc/pihole/adlists.list
else
echo ""
fi }
