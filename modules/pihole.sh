#!/bin/sh
## pihole
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install pihole?" 8 78) then
echo "User Declined Pi-Hole"
else
sudo bash /etc/piadvanced/installscripts/piholeinstall.sh

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install the Wally3k adlists.list?" 8 78) then
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Would you like to copy adlists.default to adlists.list instead?" 8 78) then
echo "User Declined Using adlists.list"
else
sudo cp /etc/pihole/adlists.default /etc/pihole/adlists.list
fi }
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/wally3k-adlists.list/master/adlists.list -P /etc/pihole/
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Dark webui theme?" 8 78) then
echo "User Declined Dark Theme"
else
sudo wget https://raw.githubusercontent.com/lkd70/PiHole-Dark/master/install.sh -P /var/www/html/
cd /var/www/html
sudo bash install.sh
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install the wally3k block page?" 8 78) then
echo "User Declined using Wally3k's Block Page"
else
sudo bash /etc/piadvanced/piholetweaks/Wally3kBlockPage.sh
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install deathbybandaid dnsmasq tweaks? See readme for more information." 8 78) then
echo "User Declined deathbybandaid dnsmasq tweaks"
else
sudo cp -n /etc/piadvanced/piholetweaks/dnsmasqtweaks/*.conf /etc/dnsmasq.d/
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do youw want to run pihole -up every 30 minutes?" 8 78) then
echo "User Declined 30 minute autoupdates"
else
(crontab -l ; echo "0,30 * * * * sudo bash /etc/piadvanced/piholetweaks/piholeautoupdate.sh") | crontab -
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want a script to keep cached lists from becoming stale?" 8 78) then
echo "User Declined Stale List Fix"
else
(crontab -l ; echo "0 5 * * 1 sudo bash /etc/piadvanced/piholetweaks/piholefreshlists.sh") | crontab -
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want a script to update gravity every 6 hours?" 8 78) then
echo "User Declined Updating gravity every 6 hours"
else
(crontab -l ; echo "0 */6 * * * sudo bash /etc/piadvanced/piholetweaks/piholegravity.sh") | crontab -
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want a program to parse additional lists? By default this uses lists used by ublock. To change the lists, edit lists.lst in /etc/piadvanced/installscripts/ublockpihole/" 8 78) then
echo "User Declined the UBlock Parser"
else
(crontab -l ; echo "0 1 * * * sudo bash /etc/piadvanced/piholetweaks/ublockpihole/ublockpihole.sh") | crontab -
sudo echo "#http://localhost/admin/ublock.txt" | sudo tee --append /etc/pihole/adlists.list
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use an script to add additional youtube adblocking?" 8 78) then
echo "User Declined the youtube ad blocker"
else
sudo pip install -r /etc/piadvanced/piholetweaks/youtubeadblock/requirements.txt
(crontab -l ; echo "0 2 * * * sudo bash /etc/piadvanced/piholetweaks/youtubeadblock/youtube-ads.sh") | crontab -
sudo echo "#http://localhost/admin/youtube.txt" | sudo tee --append /etc/pihole/adlists.list
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use a script to add adguard blocking?" 8 78) then
echo "User Declined adguard parser"
else
(crontab -l ; echo "0 3 * * * sudo bash /etc/piadvanced/piholetweaks/adguard.sh") | crontab -
sudo echo "#http://localhost/admin/adguard.txt" | sudo tee --append /etc/pihole/adlists.list
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use the PHP Parser?" 8 78) then
echo "User Declined the PHP Parser"
else
sudo cp /etc/piadvanced/piholetweaks/parser.php /var/www/html/admin/
sudo echo "#http://localhost/admin/parser.php?list=antipopads" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adware_filters" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=easyprivacy_easylist" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adguard_dns" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=fanboy_ultimate" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=blockzilla" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=openpish" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=malwareurls" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adguard_mobile" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=easylist_de2" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adguard_en" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adguard_de" | sudo tee --append /etc/pihole/adlists.list
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use HenningVanRaumle's youtube adblock list?" 8 78) then
echo "User Declined HenningVanRaumle"
else
sudo echo "#https://raw.githubusercontent.com/HenningVanRaumle/pihole-ytadblock/master/ytadblock.txt" | sudo tee --append /etc/pihole/adlists.list
fi }

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install pihole tweeter?" 8 78) then
echo "User Declined Tweeter"
else
sudo apt-get install -y python3-pip
sudo python3 -m pip install tweepy
sudo python3 -m pip install request
sudo python3 -m pip install urllib
sudo python3 -m pip install json
sudo python3 -m pip install simplejson
sudo python3 -m pip install datetime
CONSUMER_KEY=$(whiptail --inputbox "Consumer Key" 20 60 "" 3>&1 1>&2 2>&3)
CONSUMER_SECRET=$(whiptail --inputbox "Consumer Secret" 20 60 "" 3>&1 1>&2 2>&3)
ACCESS_TOKEN=$(whiptail --inputbox "Access Token" 20 60 "" 3>&1 1>&2 2>&3)
ACCESS_TOKEN_SECRET=$(whiptail --inputbox "Access Token Secret" 20 60 "" 3>&1 1>&2 2>&3)
sudo sed -i "s/VALUE1/$CONSUMER_KEY/" /etc/piadvanced/piholetweaks/twittertweeter-ads.py
sudo sed -i "s/VALUE2/$CONSUMER_SECRET/" /etc/piadvanced/piholetweaks/twittertweeter-ads.py
sudo sed -i "s/VALUE3/$ACCESS_TOKEN/" /etc/piadvanced/piholetweaks/twittertweeter-ads.py
sudo sed -i "s/VALUE4/$ACCESS_TOKEN_SECRET/" /etc/piadvanced/piholetweaks/twittertweeter-ads.py
(crontab -l ; echo "59 23 * * * sudo python3 /etc/piadvanced/piholetweaks/twittertweeter-ads.py") | crontab -
fi }

fi }
