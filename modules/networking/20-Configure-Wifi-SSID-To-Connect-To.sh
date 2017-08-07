#!/bin/sh
## Connect to wifi

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/variables.var

## Current User
CURRENTUSER="$(whoami)"

## SSID
NEW_SSID=$(whiptail --inputbox "Please enter SSID" 10 80 "" 3>&1 1>&2 2>&3)

## Wifi Password
NEW_PSK=$(whiptail --inputbox "Please enter wifi password" 10 80 "" 3>&1 1>&2 2>&3)
sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/piadvanced/backups/

## Set it up
sudo echo "" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "## Wifi" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "network={"| sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "    ssid=""$NEW_SSID""" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "    psk=""$NEW_PSK""" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "}" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf

## install vars
sudo echo "NEWWLAN_IP=$NEWWLAN_IP" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "NEW_SSID=$NEW_SSID" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "NEW_PSK=$NEW_PSK" | sudo tee --append /etc/piadvanced/install/variables.conf
