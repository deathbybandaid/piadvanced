#!/bin/sh
## DNSCRYPT
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install DNSCrypt?" 8 78) then
echo "User Declined DNSCrypt"
else
sudo bash /etc/piadvanced/installscripts/dnsproxy/dnscryptinstall.sh
sudo echo "dnscryptfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
sudo cp /etc/piadvanced/piholetweaks/dnscrypt/10-dnscrypt.conf /etc/dnsmasq.d/
fi }
