#!/bin/sh
## AtoMiC-ToolKit

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "AtoMiC-ToolKit" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install and use the AtoMiC-ToolKit for htpc softwares?" 10 80) 
then
echo "User Declined Atomic"
else
sudo git clone https://github.com/htpcBeginner/AtoMiC-ToolKit ~/AtoMiC-ToolKit
sudo bash ~/AtoMiC-ToolKit/setup.sh
whiptail --msgbox "Any programs installed via Atomic need firewall rules." 10 80 1
fi }
