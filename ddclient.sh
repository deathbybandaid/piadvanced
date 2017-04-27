#!/bin/sh
## ddclient
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install ddclient?" 8 78) then
echo "User Declined ddclient"
else
sudo apt-get install -y ddclient
fi }
