#!/bin/sh
## Squid
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Squid?" 8 78) then



echo "not installing stuff"

else

echo "installing stuff"


## Squidguard
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Squidguard?" 8 78) then



echo "not installing stuff"

else

echo "installing stuff"



fi }
fi }

