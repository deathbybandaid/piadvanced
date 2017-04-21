#!/bin/sh
## Plexboard
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Plexboard?" 8 78) then
echo "User Declined Plexboard"
else
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Warning: this takes 15 minutes on a pi3, 2 hours on the pi1" 8 78) then
echo "User Declined Plexboard"
else
curl -sSL https://get.rvm.io | bash -s stable
source /home/pi/.rvm/scripts/rvm
rvm requirements
sudo chmod 777 /opt -R && cd /opt
git clone https://github.com/scytherswings/Plex-Board.git && cd /opt/Plex-Board
rvm install 2.3.4 && rvm use 2.3.4@plexdashboard --create
./serverSetup.sh
./startServer.sh
fi }
fi }
