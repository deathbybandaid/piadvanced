## Hostname
{ whiptail --msgbox "Let's get some basic network questions first" 20 70 1
OLD_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
NEW_HOSTNAME=$(whiptail --inputbox "Please enter a hostname" 20 60 "$OLD_HOSTNAME" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo echo "NEW_HOSTNAME=$NEW_HOSTNAME" | sudo tee --append /home/dbbvariables
sudo echo "$NEW_HOSTNAME" > /etc/hostname
sudo sed -i "s/127.0.1.1.*$OLD_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
fi }

## Static IP for eth0
{ whiptail --msgbox "Let's Set a static ip for eth0" 20 70 1
OLDETH_IP=`ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
OLDETH_GATEWAY=`ip route show 0.0.0.0/0 dev eth0 | cut -d\  -f3`
NEWETH_IP=$(whiptail --inputbox "Please enter desired IP for eth0" 20 60 "$OLDETH_IP" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo echo "NEWETH_IP=$NEWETH_IP" | sudo tee --append /home/dbbvariables
sudo echo "" | sudo tee --append /etc/dhcpcd.conf
sudo echo "#eth0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "interface eth0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static ip_address=$NEWETH_IP" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static routers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static domain_name_servers=$OLDETH_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
fi }

## Wifi Credentials and Staic IP for wlan0
{ whiptail --msgbox "Let's connect to wifi using wlan0" 20 70 1
OLDWLAN_IP=`ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
NEW_SSID=$(whiptail --inputbox "Please enter SSID" 20 60 "" 3>&1 1>&2 2>&3)
NEW_PSK=$(whiptail --inputbox "Please enter wifi password" 20 60 "" 3>&1 1>&2 2>&3)
whiptail --msgbox "Let's set a static IP using wlan0" 20 70 1
OLDWLAN_GATEWAY=`ip route show 0.0.0.0/0 dev wlan0 | cut -d\  -f3`
NEWWLAN_IP=$(whiptail --inputbox "Please enter desired IP for wlan0" 20 60 "$OLDWLAN_IP" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo echo "NEWWLAN_IP=$NEWWLAN_IP" | sudo tee --append /home/dbbvariables
sudo echo "NEW_SSID=$NEW_SSID" | sudo tee --append /home/dbbvariables
sudo echo "NEW_PSK=$NEW_PSK" | sudo tee --append /home/dbbvariables
sudo echo "" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "## Wifi" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "network={"| sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "ssid="$NEW_SSID"" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "psk=$NEW_PSK" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "}" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo "" | sudo tee --append /etc/dhcpcd.conf
sudo echo "#wlan0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "interface wlan0" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static ip_address=$NEWWLAN_IP" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static routers=$OLDWLAN_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
sudo echo "static domain_name_servers=$OLDWLAN_GATEWAY" | sudo tee --append /etc/dhcpcd.conf
fi }
