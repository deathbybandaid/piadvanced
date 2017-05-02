#!/bin/sh
## pihole tweeter

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

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
sudo cp -n /etc/piadvanced/piholetweaks/twittertweeter-ads.py /etc/piadvanced/piholetweaks/piholetweeter.py
CONSUMER_KEY=$(whiptail --inputbox "Consumer Key" 20 60 "" 3>&1 1>&2 2>&3)
CONSUMER_SECRET=$(whiptail --inputbox "Consumer Secret" 20 60 "" 3>&1 1>&2 2>&3)
ACCESS_TOKEN=$(whiptail --inputbox "Access Token" 20 60 "" 3>&1 1>&2 2>&3)
ACCESS_TOKEN_SECRET=$(whiptail --inputbox "Access Token Secret" 20 60 "" 3>&1 1>&2 2>&3)
sudo sed -i "s/VALUE1/$CONSUMER_KEY/" /etc/piadvanced/piholetweaks/piholetweeter.py
sudo sed -i "s/VALUE2/$CONSUMER_SECRET/" /etc/piadvanced/piholetweaks/piholetweeter.py
sudo sed -i "s/VALUE3/$ACCESS_TOKEN/" /etc/piadvanced/piholetweaks/piholetweeter.py
sudo sed -i "s/VALUE4/$ACCESS_TOKEN_SECRET/" /etc/piadvanced/piholetweaks/piholetweeter.py
(crontab -l ; echo "59 23 * * * sudo python3 /etc/piadvanced/piholetweaks/piholetweeter.py") | crontab -
fi }
