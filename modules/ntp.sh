#!/bin/sh
## NTP

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "NTP Server" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to set ntp servers? serverlist is available at http://support.ntp.org/bin/view/Servers/NTPPoolServers" 10 80) 
then
echo "User Declined Changing NTP Server"
else
NEW_NTP=$(whiptail --inputbox "Set server here" 10 80 "debian.pool.ntp.org" 3>&1 1>&2 2>&3)
sudo cp /etc/ntp.conf /etc/piadvanced/backups/
sudo sed -i "s/pool 0.debian.pool.ntp.org iburst/pool 0.$NEW_NTP iburst/" /etc/ntp.conf
sudo sed -i "s/pool 1.debian.pool.ntp.org iburst/pool 1.$NEW_NTP iburst/" /etc/ntp.conf
sudo sed -i "s/pool 2.debian.pool.ntp.org iburst/pool 2.$NEW_NTP iburst/" /etc/ntp.conf
sudo sed -i "s/pool 3.debian.pool.ntp.org iburst/pool 3.$NEW_NTP iburst/" /etc/ntp.conf
sudo service ntp stop
sudo ntpd -gq
sudo service ntp start
fi }
