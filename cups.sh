#!/bin/sh
## Cups
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Cups?" 8 78) then



echo "not installing stuff"

else

echo "installing stuff"



fi }

