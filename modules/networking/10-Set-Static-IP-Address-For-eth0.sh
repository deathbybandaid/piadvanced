#!/bin/sh
## Set a Static IP Address For eth0

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/variables.var

## Current User
CURRENTUSER="$(whoami)"

## Get Current IP
OLDETH_IP=`ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`

## GateWay
OLDETH_GATEWAY=`ip route show 0.0.0.0/0 dev eth0 | cut -d\  -f3`

## What to set it to
NEWETH_IP=$(whiptail --inputbox "Please enter desired IP for eth0" 10 80 "$OLDETH_IP" 3>&1 1>&2 2>&3)

## Make Backup
sudo cp /etc/dhcpcd.conf /etc/piadvanced/backups/dhcpcd.conf

## Remove old Lines if there
sudo sed -i '/#eth0/d' /etc/dhcpcd.conf
sudo sed -i '/interface eth0/d' /etc/dhcpcd.conf
sudo sed -i '/static ip_address=$OLDETH_IP/d' /etc/dhcpcd.conf
sudo sed -i '/static routers=$OLDETH_GATEWAY/d' /etc/dhcpcd.conf
sudo sed -i '/static domain_name_servers=$OLDETH_GATEWAY/d' /etc/dhcpcd.conf

## add to dhcpcd
sudo echo "" | sudo tee --append /etc/dhcpcd.conf
sudo echo "#eth0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "interface eth0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static ip_address=$NEWETH_IP" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static routers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static domain_name_servers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf

## actually set it
sudo ifconfig eth0 $NEWETH_IP

## Set Script Vars
sudo echo "NEWETH_IP=$NEWETH_IP" | sudo tee --append /etc/piadvanced/install/variables.conf
