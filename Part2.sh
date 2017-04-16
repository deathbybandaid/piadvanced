#!/bin/sh
{ whiptail --msgbox "This is The Deathbybandaid Pihole Install" 20 70 1
whiptail --msgbox "Let's get some network questions first" 20 70 1
OLD_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
OLDETH_IP=`ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
OLDWLAN_IP=`ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
OLDETH_GATEWAY=`ip route show 0.0.0.0/0 dev eth0 | cut -d\  -f3`
NEW_HOSTNAME=$(whiptail --inputbox "Please enter a hostname" 20 60 "$OLD_HOSTNAME" 3>&1 1>&2 2>&3)
whiptail --msgbox "Let's Set a static ip for eth0" 20 70 1
NEWETH_IP=$(whiptail --inputbox "Please enter desired IP for eth0" 20 60 "$OLDETH_IP" 3>&1 1>&2 2>&3)
whiptail --msgbox "Let's connect to wifi using wlan0" 20 70 1
NEW_SSID=$(whiptail --inputbox "Please enter SSID" 20 60 "" 3>&1 1>&2 2>&3)
NEW_PSK=$(whiptail --inputbox "Please enter wifi password" 20 60 "" 3>&1 1>&2 2>&3)
whiptail --msgbox "Let's set a static IP using wlan0" 20 70 1
OLDWLAN_GATEWAY=`ip route show 0.0.0.0/0 dev wlan0 | cut -d\  -f3`
NEWWLAN_IP=$(whiptail --inputbox "Please enter desired IP for wlan0" 20 60 "$OLDWLAN_IP" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo echo "OLD_HOSTNAME=$OLD_HOSTNAME" | sudo tee --append /home/dbbvariables
sudo echo "NEW_HOSTNAME=$NEW_HOSTNAME" | sudo tee --append /home/dbbvariables
sudo echo "OLDETH_GATEWAY=$OLDETH_GATEWAY" | sudo tee --append /home/dbbvariables
sudo echo "OLDWLAN_GATEWAY=$OLDWLAN_GATEWAY" | sudo tee --append /home/dbbvariables
sudo echo "OLDETH_IP=$OLDETH_IP" | sudo tee --append /home/dbbvariables
sudo echo "NEWETH_IP=$NEWETH_IP" | sudo tee --append /home/dbbvariables
sudo echo "OLDWLAN_IP=$OLDWLAN_IP" | sudo tee --append /home/dbbvariables
sudo echo "NEWWLAN_IP=$NEWWLAN_IP" | sudo tee --append /home/dbbvariables
sudo echo "NEW_SSID=$NEW_SSID" | sudo tee --append /home/dbbvariables
sudo echo "NEW_PSK=$NEW_PSK" | sudo tee --append /home/dbbvariables
sudo echo $NEW_HOSTNAME > /etc/hostname
sudo sed -i "s/127.0.1.1.*$OLD_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
sudo echo "#eth0" | sudo tee --append /etc/dhcpcd.conf
sudo echo interface eth0 | sudo tee --append /etc/dhcpcd.conf
sudo echo static ip_address=$NEWETH_IP | sudo tee --append /etc/dhcpcd.conf
sudo echo static routers=$OLDETH_GATEWAY | sudo tee --append /etc/dhcpcd.conf
sudo echo static domain_name_servers=$OLDETH_GATEWAY | sudo tee --append /etc/dhcpcd.conf
sudo echo ## Wifi | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo network={ | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo ssid="$NEW_SSID" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo psk=$NEW_PSK | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo } | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo #wlan0 | sudo tee --append /etc/dhcpcd.conf
sudo echo interface wlan0 | sudo tee --append /etc/dhcpcd.conf
sudo echo static ip_address=$NEWWLAN_IP | sudo tee --append /etc/dhcpcd.conf
sudo echo static routers=$OLDWLAN_GATEWAY | sudo tee --append /etc/dhcpcd.conf
sudo echo static domain_name_servers=$OLDWLAN_GATEWAY | sudo tee --append /etc/dhcpcd.conf
fi }
{
  dpkg-reconfigure tzdata
}
{ whiptail --yesno "Would you like the SSH server enabled or disabled?" 20 60 2 \
--yes-button Enable --no-button Disable
RET=$?
if [ $RET -eq 0 ]; then
update-rc.d ssh enable &&
invoke-rc.d ssh start &&
whiptail --msgbox "SSH server enabled" 20 60 1
elif [ $RET -eq 1 ]; then
update-rc.d ssh disable &&
whiptail --msgbox "SSH server disabled" 20 60 1
else
return $RET
fi }
{ if (whiptail --yesno "Do you plan on running headless?" 8 78) then
sudo sed -i "s/\($gpu_mem *= *\).*/\1$116/"  /boot/config.txt
else
echo ""
fi }
