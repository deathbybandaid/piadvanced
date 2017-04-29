#!/bin/sh
## PSAD
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install psad?" 8 78) then
echo "User Declined PSAD"
else
sudo wget http://cipherdyne.org/psad/download/psad-2.4.4.tar.gz -P /etc/piadvanced/installscripts/
sudo tar xzf psad-2.4.4.tar.gz
cd psad-2.4.4
sudo ./install.pl
fi }
