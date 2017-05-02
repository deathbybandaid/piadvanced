#!/bin/sh
## No-IP

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you plan on using the No-IP dynamic Update Client?" 10 80) 
then
echo "User Declined NOIP DUC"
else
sudo mkdir /home/installs/noip
sudo wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz -P /etc/piadvanced/installscripts/noip/
cd /etc/piadvanced/installscripts/noip/
sudo tar vzxf noip-duc-linux.tar.gz
cd /etc/piadvanced/installscripts/noip/noip-2.1.9-1/
sudo make
sudo make install
sudo /usr/local/bin/noip2
sudo noip2 ­-S
fi }
