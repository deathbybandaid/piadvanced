#!/bin/sh
################################################################
##          This is The Deathbybandaid Pihole Install         ##
################################################################
##    This Must be run as root, or it fails is some places    ##
################################################################

## This is where we will download installations.
sudo mkdir /etc/piadvanced/installscripts

## This is where we will put backups of important files. I maywrite a reversion script later.
sudo mkdir /etc/piadvanced/backups

## This document will contain all of our setup variables. Date/Time Stamped.
mkdir /etc/piadvanced/install
timestamp=`date --rfc-3339=seconds`
sudo echo "## Variables for Install" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "## $timestamp" | sudo tee --append /etc/piadvanced/install/variables.conf

## Here we Go!!
whiptail --msgbox "This is The Deathbybandaid Pihole Install" 20 70 1

## Static Ip's and wifi connection.
sudo bash /etc/piadvanced/network.sh

## Memory Split
sudo bash /etc/piadvanced/memorysplit.sh

## Some other basic settings
sudo bash /etc/piadvanced/otherbasics.sh

## Time
sudo bash /etc/piadvanced/ntp.sh

## Random Number Generation fix
sudo bash /etc/piadvanced/randomnumberfix.sh

## Sources && Update && Upgrade
sudo bash /etc/piadvanced/sources.sh
sudo bash /etc/piadvanced/updateupgrade.sh
sudo bash /etc/piadvanced/aptgetinstall.sh

## Admin Email
sudo bash /etc/piadvanced/apticron.sh
sudo bash /etc/piadvanced/mail.sh

## DNSmasq
sudo bash /etc/piadvanced/dnsmasq.sh

## DNSCrypt
sudo bash /etc/piadvanced/dnscrypt.sh

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

## iptools firewall
