#!/bin/sh
## Set a Static IP Address For eth0

## Current User
CURRENTUSER="$(whoami)"

OLDETH_IP=`ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
OLDETH_GATEWAY=`ip route show 0.0.0.0/0 dev eth0 | cut -d\  -f3`
NEWETH_IP=$(whiptail --inputbox "Please enter desired IP for eth0" 10 80 "$OLDETH_IP" 3>&1 1>&2 2>&3)
sudo cp /etc/dhcpcd.conf /etc/piadvanced/backups/dhcpcd.conf
sudo sed -i '/#eth0/d' /etc/dhcpcd.conf
sudo sed -i '/interface eth0/d' /etc/dhcpcd.conf
sudo sed -i '/static ip_address=$OLDETH_IP/d' /etc/dhcpcd.conf
sudo sed -i '/static routers=$OLDETH_GATEWAY/d' /etc/dhcpcd.conf
sudo sed -i '/static domain_name_servers=$OLDETH_GATEWAY/d' /etc/dhcpcd.conf
sudo echo "NEWETH_IP=$NEWETH_IP" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "" | sudo tee --append /etc/dhcpcd.conf
sudo echo "#eth0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "interface eth0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static ip_address=$NEWETH_IP" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static routers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static domain_name_servers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
sudo ifconfig eth0 $NEWETH_IP
