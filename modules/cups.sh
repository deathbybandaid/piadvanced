#!/bin/sh
## Cups

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "Cups" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Cups?" 10 80) 
then
echo "User Declined CUPS"
else
sudo apt-get install -y cups
{ if 
[ "$CHANGED_USERNAME" = "yes" ]
then
sudo usermod -a -G lpadmin $NEW_USERNAME
else
sudo usermod -a -G lpadmin pi
fi }
sudo sed -i "s/Listen localhost:631/Port 631/" /etc/cups/cupsd.conf
sudo gawk -i inplace '/Order deny,allow/{print;print "Allow from all";next}1' /etc/cups/cupsd.conf
sudo gawk -i inplace '/Order allow,deny/{print;print "Allow from all";next}1' /etc/cups/cupsd.conf
sudo /etc/init.d/cups restart
sudo echo "cupsfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
