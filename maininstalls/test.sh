#!/bin/sh
################################################################
##          This is The Deathbybandaid Pi Install         ##
################################################################
##    This Must be run as root, or it fails is some places    ##
################################################################

## These documents will contain all of our setup variables. Date/Time Stamped.
timestamp=`date --rfc-3339=seconds`
{ if (whiptail --yes-button "First Time!" --no-button "Not The First Time!" --yesno "Is this the First run of this install?" 8 78) then
sudo echo "## $timestamp" | sudo tee --append /etc/piadvanced/install/variables.conf /etc/piadvanced/install/firewall.conf
else
sudo mv /etc/piadvanced/install/variables.conf /etc/piadvanced/install/firewall.conf /etc/piadvanced/backups/
sudo echo "## $timestamp" | sudo tee --append /etc/piadvanced/install/variables.conf /etc/piadvanced/install/firewall.conf
fi }

## Here we Go!!
whiptail --msgbox "This is The Deathbybandaid Pi Install" 20 70 1

## Hostname
sudo bash /etc/piadvanced/maininstalls/hostname.sh

## Static IP for eth0
sudo bash /etc/piadvanced/maininstalls/eth0.sh

## Wifi Credentials
sudo bash /etc/piadvanced/maininstalls/wifissid.sh

## Staic IP for wlan0
sudo bash /etc/piadvanced/maininstalls/wlan0.sh

## Memory Split
sudo bash /etc/piadvanced/maininstalls/memorysplit.sh

## SSH
sudo bash /etc/piadvanced/maininstalls/ssh.sh

## Time
sudo bash /etc/piadvanced/maininstalls/ntp.sh

## Random Number Generation fix
sudo bash /etc/piadvanced/maininstalls/randomnumberfix.sh

## Better MOTD message
sudo bash /etc/piadvanced/maininstalls/motd.sh

## Sources && Update && Upgrade
sudo bash /etc/piadvanced/maininstalls/sources.sh
sudo bash /etc/piadvanced/maininstalls/updateupgrade.sh
sudo bash /etc/piadvanced/maininstalls/aptgetinstall.sh

## Admin Email
sudo bash /etc/piadvanced/maininstalls/apticron.sh
sudo bash /etc/piadvanced/maininstalls/mail.sh
sudo bash /etc/piadvanced/maininstalls/exim4.sh

## DNSmasq
sudo bash /etc/piadvanced/maininstalls/dnsmasq.sh

## Fail2Ban
sudo bash /etc/piadvanced/maininstalls/fail2ban.sh

## PSAD
sudo bash /etc/piadvanced/maininstalls/psad.sh

## No-ip Dynamic Update Client
sudo bash /etc/piadvanced/maininstalls/noip.sh

## Dyndns
sudo bash /etc/piadvanced/maininstalls/ddclient.sh

## VPNs
whiptail --msgbox "The next two installs are openvpn and pivpn, choose one ONLY!" 20 70 1

## OpenVPN
sudo bash /etc/piadvanced/maininstalls/openvpn.sh

## pivpn
sudo bash /etc/piadvanced/maininstalls/pivpn.sh

## Pi-Hole
sudo bash /etc/piadvanced/maininstalls/pihole.sh

## DNSCrypt
sudo bash /etc/piadvanced/maininstalls/dnscrypt.sh

## Webserver settings
whiptail --msgbox "During the install, multiple webservers could have been installed. Let's try to adjust the configs to not interfere with eachother" 20 70 1
whiptail --msgbox "If these aren't set correctly, you will have to manually adjust them, because they may not start properly." 20 70 1
sudo bash /etc/piadvanced/maininstalls/apache.sh
sudo bash /etc/piadvanced/maininstalls/lighttpd.sh
sudo bash /etc/piadvanced/maininstalls/nginx.sh

## Usermin
sudo bash /etc/piadvanced/maininstalls/usermin.sh

## Webmin
sudo bash /etc/piadvanced/maininstalls/webmin.sh

## xRDP
sudo bash /etc/piadvanced/maininstalls/xrdp.sh

## Guacamole
sudo bash /etc/piadvanced/maininstalls/guacamole.sh

## CUPS
sudo bash /etc/piadvanced/maininstalls/cups.sh

## rpimonitor
sudo bash /etc/piadvanced/maininstalls/rpimonitor.sh

## Proxies
whiptail --msgbox "The next two installs are Squid and Privoxy, choose one ONLY!" 20 70 1

## Privoxy
sudo bash /etc/piadvanced/maininstalls/privoxy.sh

## Squid
sudo bash /etc/piadvanced/maininstalls/squid.sh

## HTPC
sudo bash /etc/piadvanced/maininstalls/atomic.sh

## Dplatform
sudo bash /etc/piadvanced/maininstalls/dplatform.sh

## THE FIREWALL!!
sudo bash /etc/piadvanced/FIREWALL.sh

## All Done
whiptail --msgbox "This concludes the script. Reboot to complete. Consult the readme for additional configuration." 20 70 1
