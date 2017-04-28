#!/bin/sh
## nagios
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install nagios?" 8 78) then



echo "not installing stuff"

else

echo "installing stuff"



fi }
