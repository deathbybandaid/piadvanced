#!/bin/sh
## Guacamole
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Guacamole?" 8 78) then



echo "not installing stuff"

else

echo "installing stuff"



fi }
