#!/bin/sh
#rpimonitor

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install rpimonitor?" 10 80) 
then
echo "User decline rpimonitor"
else
sudo wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list
sudo apt-get install -y rpimonitor
sudo /etc/init.d/rpimonitor update
sudo sed -i "s/#daemon.port=8889/daemon.port=8889/" /etc/rpimonitor/daemon.conf
sudo service rpimonitor restart
sudo echo "rpimonitorfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
