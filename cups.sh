#!/bin/sh
## Cups
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Cups?" 8 78) then
echo "User Declined CUPS"
else
sudo apt-get install -y cups
sudo usermod -a -G lpadmin pi
sudo sed -i "s/Listen localhost:631/Port 631/" /etc/cups/cupsd.conf
sudo gawk -i inplace '/Order deny,allow/{print;print "Allow from all";next}1' /etc/cups/cupsd.conf
sudo gawk -i inplace '/Order allow,deny/{print;print "Allow from all";next}1' /etc/cups/cupsd.conf
#sudo awk '/Order deny,allow/{print;print "Allow from all";next}1' /etc/cups/cupsd.conf
#sudo awk '/Order allow,deny/{print;print "Allow from all";next}1' /etc/cups/cupsd.conf
#sed "/'Order allow,deny'/a 'Allow from all'" /etc/cups/cupsd.conf
sudo /etc/init.d/cups restart
sudo echo "cupsfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
