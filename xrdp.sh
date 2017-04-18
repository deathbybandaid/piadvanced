#!/bin/sh
## XRDP
{ if (whiptail --yesno "Do you want to install xrdp?" 8 78) then
sudo apt-get install -y xrdp
else
echo ""
fi }
