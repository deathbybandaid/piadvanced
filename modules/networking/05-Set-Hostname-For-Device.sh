#!/bin/sh
## Set The Hostname

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/variables.var

## Current User
CURRENTUSER="$(whoami)"

## Current Hostname
OLD_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`

## Set The hostname
NEW_HOSTNAME=$(whiptail --inputbox "Please enter a hostname" 10 80 "$OLD_HOSTNAME" 3>&1 1>&2 2>&3)

## Create Backup
sudo cp /etc/hosts /etc/piadvanced/backups/hostname/
sudo cp /etc/hostname /etc/piadvanced/backups/hostname/

## set new
sudo echo "NEW_HOSTNAME=$NEW_HOSTNAME" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "$NEW_HOSTNAME" > /etc/hostname
sudo sed -i "s/127.0.0.1.*$OLD_HOSTNAME/127.0.0.1\t$NEW_HOSTNAME/g" /etc/hosts
