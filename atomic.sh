#!/bin/sh
## AtoMiC-ToolKit
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install and use the AtoMiC-ToolKit for htpc softwares?" 8 78) then
echo "User Declined Atomic"
else
sudo git clone https://github.com/htpcBeginner/AtoMiC-ToolKit ~/AtoMiC-ToolKit
sudo bash ~/AtoMiC-ToolKit/setup.sh
fi }
