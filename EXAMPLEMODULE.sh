#!/bin/sh
## NAMEOFAPP
NAMEOFAPP="PUTNAMEOFAPPHERE" # This helps set the name of your app throught the module.
WHATITDOES="PUTABRIEFDESCRIPTIONOFTHEPROGRAMHERE"

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables (if in every file, an installer can be re-run independently)
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 8 78) 
then
echo "$CURRENTUSER Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=no" | sudo tee --append /etc/piadvanced/install/variables.conf
else
echo "$CURRENTUSER Accepted $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=yes" | sudo tee --append /etc/piadvanced/install/variables.conf

## Below here is the magic.


## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments

## Need a message box?
#whiptail --msgbox "$NAMEOFAPP messagebox" 20 70 1

## Set a variable with a text box?
#NEW_VARIABLE=$(whiptail --inputbox "NAMEOFAPP what do you want to type?" 10 80 "$NAMEOFAPP suggested text" 3>&1 1>&2 2>&3)

## Execute install script
#sudo bash /etc/piadvanced/installscripts/NAMEOFAPPinstall.sh

## If Firewall rule is needed
#sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf

## Save variable to the conf
#sudo echo "NEW_VARIABLE=$NEW_VARIABLE" | sudo tee --append /etc/piadvanced/install/variables.conf
