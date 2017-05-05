#!/bin/sh
## speedtest.cli
NAMEOFAPP="speedtestcli"
WHATITDOES="This will tweet when internet spedds are not good."

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
sudo git clone https://github.com/deathbybandaid/netmon.git /etc/piadvanced/netmon
sudo pip install -r /etc/piadvanced/netmon/requirements.txt
sudo cp /etc/piadvanced/installscripts/speedtweet/auth.json.sample /etc/piadvanced/netmon/auth.json
SPEEDCONSUMER_KEY=$(whiptail --inputbox "Consumer Key" 20 60 "" 3>&1 1>&2 2>&3)
SPEEDCONSUMER_SECRET=$(whiptail --inputbox "Consumer Secret" 20 60 "" 3>&1 1>&2 2>&3)
SPEEDACCESS_TOKEN=$(whiptail --inputbox "Access Token" 20 60 "" 3>&1 1>&2 2>&3)
SPEEDACCESS_TOKEN_SECRET=$(whiptail --inputbox "Access Token Secret" 20 60 "" 3>&1 1>&2 2>&3)
sudo sed -i "s/VALUE1/$CONSUMER_KEY/" /etc/piadvanced/netmon/auth.json.sample
sudo sed -i "s/VALUE2/$CONSUMER_SECRET/" /etc/piadvanced/netmon/auth.json.sample
sudo sed -i "s/VALUE3/$ACCESS_TOKEN/" /etc/piadvanced/netmon/auth.json.sample
sudo sed -i "s/VALUE4/$ACCESS_TOKEN_SECRET/" /etc/piadvanced/netmon/auth.json.sample
sudo python /etc/piadvanced/netmon/netmon.py -d 100M -u 5M -c /etc/piadvanced/netmon/auth.json -m "I'm paying for 100 Mbps/6 Mbps and I'm only getting %s/%s right now!"
sudo sed -i '/exit 0/d' /etc/rc.local
sudo sed -i '' /etc/rc.local
sudo sed -i '$i /etcpiadvanced/installscripts/speedtweet.sh &' /etc/rc.local
sudo sed -i '' /etc/rc.local
sudo sed -i '$i exit 0' /etc/rc.local
sudo sed -i '' /etc/rc.local


## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
