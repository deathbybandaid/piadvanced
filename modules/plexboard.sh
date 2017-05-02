#!/bin/sh
## Plexboard

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Plexboard?" 10 80) 
then
echo "User Declined Plexboard"
else
curl -sSL https://get.rvm.io | bash -s stable
source /home/pi/.rvm/scripts/rvm
rvm requirements
sudo chmod 777 /opt -R && cd /opt
git clone https://github.com/scytherswings/Plex-Board.git && cd /opt/Plex-Board
rvm install 2.3.4 && rvm use 2.3.4@plexdashboard --create
./serverSetup.sh
sudo echo "plexboardfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
