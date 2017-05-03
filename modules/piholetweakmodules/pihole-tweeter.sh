#!/bin/sh
## pihole tweeter
NAMEOFAPP="piholetweeter"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install $NAMEOFAPP?" 10 80) 
then
echo "User Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
else
echo "User Installed $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
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
(crontab -l ; echo "59 23 * * * sudo bash /etc/piadvanced/piholetweaks/piholetweeter.sh") | crontab -
fi }

unset NAMEOFAPP
