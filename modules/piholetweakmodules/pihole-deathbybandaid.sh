#!/bin/sh
## Deathbybandaid dnsmasq tweaks

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf


{ if 
(whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install deathbybandaid dnsmasq tweaks? See readme for more information." 8 78) 
then
echo "User Declined deathbybandaid dnsmasq tweaks"
else
sudo cp -n /etc/piadvanced/piholetweaks/dnsmasqtweaks/*.conf /etc/dnsmasq.d/
fi }
