#!/bin/sh
## exim4
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install exim4?" 8 78) then
echo "User Declined Exim4"
else
sudo apt-get install -y exim4 
sudo dpkg-reconfigure exim4-config
fi }
