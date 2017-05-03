#!/bin/sh
## DNSCRYPT

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "DNSCrypt" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install DNSCrypt?" 10 80) 
then
echo "User Declined DNSCrypt"
else
sudo bash /etc/piadvanced/installscripts/dnsproxy/dnscryptinstall.sh
sudo echo "dnscryptfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
sudo cp -n /etc/piadvanced/piholetweaks/dnscrypt/10-dnscrypt.conf /etc/dnsmasq.d/
fi }
