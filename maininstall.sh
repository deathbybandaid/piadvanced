#!/bin/sh
################################################################
##          This is The Deathbybandaid Pihole Install         ##
################################################################
##    This Must be run as root, or it fails is some places    ##
################################################################
{ if (whiptail --title "Deathbybandaid" --yesno "Are you running as root?" 8 78) then
echo ""
else
exit
fi }
## Here's our basic Settings
{ whiptail --msgbox "This is The Deathbybandaid Pihole Install" 20 70 1
whiptail --msgbox "Let's get some network questions first" 20 70 1
CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
CURRENTWLAN_IP=`echo `ifconfig wlan0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'``
CURRENTETH_IP=`echo `ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'``
CURRENTETH_GATEWAY=`ip route show 0.0.0.0/0 dev eth0 | cut -d\  -f3`
NEW_HOSTNAME=$(whiptail --inputbox "Please enter a hostname" 20 60 "$CURRENT_HOSTNAME" 3>&1 1>&2 2>&3)
whiptail --msgbox "Let's Set a static ip for eth0" 20 70 1
NEWETH_IP=$(whiptail --inputbox "Please enter desired IP for eth0" 20 60 "$CURRENTETH_IP" 3>&1 1>&2 2>&3)
whiptail --msgbox "Let's connect to wifi using wlan0" 20 70 1
NEW_SSID=$(whiptail --inputbox "Please enter SSID" 20 60 "" 3>&1 1>&2 2>&3)
NEW_PSK=$(whiptail --inputbox "Please enter wifi password" 20 60 "" 3>&1 1>&2 2>&3)
whiptail --msgbox "Let's set a static IP using wlan0" 20 70 1
CURRENTWLAN_GATEWAY=`ip route show 0.0.0.0/0 dev wlan0 | cut -d\  -f3`
NEWWLAN_IP=$(whiptail --inputbox "Please enter desired IP for wlan0" 20 60 "$CURRENTWLAN_IP" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then 
echo $NEW_HOSTNAME > /etc/hostname
sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
echo #eth0 | sudo tee --append /etc/dhcpcd.conf
echo interface eth0 | sudo tee --append /etc/dhcpcd.conf
echo static ip_address=$NEWETH_IP | sudo tee --append /etc/dhcpcd.conf
echo static routers=$CURRENTETH_GATEWAY | sudo tee --append /etc/dhcpcd.conf
echo static domain_name_servers=$CURRENTETH_GATEWAY | sudo tee --append /etc/dhcpcd.conf
echo ## Wifi | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
echo network={ | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
echo ssid="$NEW_SSID" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
echo psk=$NEW_PSK | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
echo } | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
echo #wlan0 | sudo tee --append /etc/dhcpcd.conf
echo interface wlan0 | sudo tee --append /etc/dhcpcd.conf
echo static ip_address=$NEWWLAN_IP | sudo tee --append /etc/dhcpcd.conf
echo static routers=$CURRENTWLAN_GATEWAY | sudo tee --append /etc/dhcpcd.conf
echo static domain_name_servers=$CURRENTWLAN_GATEWAY | sudo tee --append /etc/dhcpcd.conf
fi }
