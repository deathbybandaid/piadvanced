#!/bin/sh
##
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to Connect to a wifi network using wlan0?" 8 78) then
echo "User Declined Connecting to wifi"
else
NEW_SSID=$(whiptail --inputbox "Please enter SSID" 20 60 "" 3>&1 1>&2 2>&3)
NEW_PSK=$(whiptail --inputbox "Please enter wifi password" 20 60 "" 3>&1 1>&2 2>&3)
sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/piadvanced/backups/
sudo echo "NEWWLAN_IP=$NEWWLAN_IP" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "NEW_SSID=$NEW_SSID" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "NEW_PSK=$NEW_PSK" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "## Wifi" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "network={"| sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "ssid="$NEW_SSID"" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "psk=$NEW_PSK" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "}" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
fi }
