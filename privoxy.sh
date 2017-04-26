#!/bin/sh
## Privoxy
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Privoxy?" 8 78) then



echo "not installing stuff"

else

echo "installing stuff"

sudo echo "privoxyfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf

fi }
