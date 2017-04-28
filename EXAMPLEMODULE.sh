#!/bin/sh
##
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install ?" 8 78) then
echo "User Declined NAMEOFAPP"

else

echo "installing stuff"


## If Firewall rule is needed, replace name of app.
#sudo echo "NAMEOFAPPfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf

fi }
