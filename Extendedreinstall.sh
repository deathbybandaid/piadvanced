#!/bin/sh
################################################################
##          This is The Deathbybandaid Pi Re-Install         ##
################################################################
##    This Must be run as root, or it fails is some places    ##
################################################################


## THIS SCRIPT IS NOT READY!!!




## This is where we will download installations.
sudo mkdir /etc/piadvanced/installscripts

## This is where we will put backups of important files. I maywrite a reversion script later.
sudo mkdir /etc/piadvanced/backups

## This document will contain all of our setup variables. Date/Time Stamped.
mkdir /etc/piadvanced/install
timestamp=`date --rfc-3339=seconds`
sudo rm -r /etc/piadvanced/install/variables.conf
sudo echo "## Variables for Install" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "## $timestamp" | sudo tee --append /etc/piadvanced/install/variables.conf

## This is where I will put firewall variables
sudo rm -r /etc/piadvanced/install/firewall.conf
sudo echo "## Variables for Firewall" | sudo tee --append /etc/piadvanced/install/firewall.conf
sudo echo "## $timestamp" | sudo tee --append /etc/piadvanced/install/firewall.conf


## Here we Go!!
whiptail --msgbox "This is The Deathbybandaid Pi Install" 20 70 1

## Hostname
sudo bash /etc/piadvanced/hostname.sh

## Static IP for eth0
sudo bash /etc/piadvanced/eth0.sh

## Wifi Credentials
sudo bash /etc/piadvanced/wifissid.sh

## Staic IP for wlan0
sudo bash /etc/piadvanced/wlan0.sh

## Memory Split
sudo bash /etc/piadvanced/memorysplit.sh

## SSH
sudo bash /etc/piadvanced/ssh.sh

## Time
sudo bash /etc/piadvanced/ntp.sh

## Random Number Generation fix
sudo bash /etc/piadvanced/randomnumberfix.sh

## Better MOTD message
sudo bash /etc/piadvanced/motd.sh

## Sources && Update && Upgrade
sudo bash /etc/piadvanced/sources.sh
sudo bash /etc/piadvanced/updateupgrade.sh
sudo bash /etc/piadvanced/aptgetinstall.sh

## Admin Email
sudo bash /etc/piadvanced/apticron.sh
sudo bash /etc/piadvanced/mail.sh

## DNSmasq
sudo bash /etc/piadvanced/dnsmasq.sh

## Fail2Ban
sudo bash /etc/piadvanced/fail2ban.sh

## PSAD
sudo bash /etc/piadvanced/psad.sh

## No-ip Dynamic Update Client
sudo bash /etc/piadvanced/noip.sh

## OpenVPN
sudo bash /etc/piadvanced/openvpn.sh

## Pi-Hole
sudo bash /etc/piadvanced/pihole.sh

## DNSCrypt
sudo bash /etc/piadvanced/dnscrypt.sh

## Webserver settings
whiptail --msgbox "During the install, multiple webservers could have been installed. Let's try to adjust the configs to not interfere with eachother" 20 70 1
whiptail --msgbox "If these aren't set correctly, you will have to manually adjust them, because they may not start properly." 20 70 1
sudo bash /etc/piadvanced/apache.sh
sudo bash /etc/piadvanced/lighttpd.sh
sudo bash /etc/piadvanced/nginx.sh
sudo service apache2 stop
sudo service lighttpd stop
sudo service nginx stop
sudo service apache2 start
sudo service lighttpd start
sudo service nginx start
## Usermin
sudo bash /etc/piadvanced/usermin.sh

## Webmin
sudo bash /etc/piadvanced/webmin.sh

## xRDP
sudo bash /etc/piadvanced/xrdp.sh

## rpimonitor
sudo bash /etc/piadvanced/rpimonitor.sh

## Add privoxy and/or squid

## HTPC
sudo bash /etc/piadvanced/atomic.sh
whiptail --msgbox "Any programs installed via Atomic need firewall rules." 20 70 1

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to set up a firewall?" 8 78) then
echo "User Declined Firewall"
else
sudo bash /etc/piadvanced/iptablesfirewall.sh
fi }

## All Done
whiptail --msgbox "This concludes the script. Reboot to complete. Consult the readme for additional configuration." 20 70 1
