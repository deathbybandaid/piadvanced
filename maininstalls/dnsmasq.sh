#!/bin/sh
## DNSMasq
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you plan on using dnsmasq?" 8 78) then
echo "User Declined DNSmasq"
else
{ if (whiptail --yes-button "Regular" --no-button "Experimental" --yesno "Do you want to use the experimental version 2.77test4?" 8 78) then
sudo apt-get install -y dnsmasq
else
sudo bash /etc/piadvanced/installscripts/dnsmasqupgrade.sh
fi }
fi }
