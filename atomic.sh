#!/bin/sh
## AtoMiC-ToolKit
{ if (whiptail --yesno "Do you want to install and use the AtoMiC-ToolKit for htpc softwares?" 8 78) then
sudo git clone https://github.com/htpcBeginner/AtoMiC-ToolKit ~/AtoMiC-ToolKit
cd ~/AtoMiC-ToolKit/setup.sh
else
echo ""
fi }
