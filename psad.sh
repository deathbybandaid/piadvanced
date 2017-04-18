#!/bin/sh
## PSAD
{ if (whiptail --yesno "Do you want to install psad?" 8 78) then
echo "Stay tuned"
sudo wget http://cipherdyne.org/psad/download/psad-2.4.4.tar.gz -P /etc/piadvanced/installscripts/
sudo tar xzf psad-2.4.4.tar.gz
cd psad-2.4.4
sudo ./install.pl
else
echo ""
fi }
