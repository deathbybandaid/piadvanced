#!/bin/sh
## pivpn
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install pivpn?" 8 78) then
echo "User Declined pivpn"
else
curl -L https://install.pivpn.io | bash
fi }
