#!/bin/sh
## Timezone

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to set the timezone?" 8 78) then
echo "User Declined Setting timezone"
else
sudo dpkg-reconfigure tzdata
fi }
