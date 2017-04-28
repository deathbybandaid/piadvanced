#!/bin/sh
## nxfilter
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install nxfilter?" 8 78) then



echo "not installing stuff"

else

echo "installing stuff"



fi }
