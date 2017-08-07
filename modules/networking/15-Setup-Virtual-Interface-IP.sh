#!/bin/sh
## two IP's one cable

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/variables.var

## Current User
CURRENTUSER="$(whoami)"

## Set IP address
NEWVLAN_IP=$(whiptail --inputbox "Please enter desired IP for eth0.1" 10 80 "$OLDETH_IP" 3>&1 1>&2 2>&3)

sudo echo "" | sudo tee --append /etc/network/interfaces
sudo echo "# VLAN x Interface" | sudo tee --append /etc/network/interfaces
sudo echo "auto eth0.1" | sudo tee --append /etc/network/interfaces
sudo echo "iface eth0.1 inet manual" | sudo tee --append /etc/network/interfaces
sudo echo "    vlan-raw-device eth0" | sudo tee --append /etc/network/interfaces
sudo echo "" | sudo tee --append /etc/dhcpcd.conf

sudo echo "# Static IP configuration VLan" | sudo tee --append /etc/dhcpcd.conf
sudo echo "interface eth0.1" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static ip_address=$NEWVLAN_IP" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static routers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static domain_name_servers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf

## flip the switch
sudo ifconfig eth0.1 $NEWVLAN_IP
