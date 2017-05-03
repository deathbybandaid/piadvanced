#!/bin/sh
## Plexboard
NAMEOFAPP="plexboard"

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
curl -sSL https://get.rvm.io | bash -s stable
source /home/pi/.rvm/scripts/rvm
rvm requirements
sudo chmod 777 /opt -R && cd /opt
git clone https://github.com/scytherswings/Plex-Board.git && cd /opt/Plex-Board
rvm install 2.3.4 && rvm use 2.3.4@plexdashboard --create
./serverSetup.sh
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }

unset NAMEOFAPP
