#!/bin/sh
################################################################
##          This is The Deathbybandaid Pihole Install         ##
################################################################
##    This Must be run as root, or it fails is some places    ##
################################################################
{ if (whiptail --yesno "Are you running as root?" 8 78) then
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
sudo sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
sudo echo #eth0 | sudo tee --append /etc/dhcpcd.conf
sudo echo interface eth0 | sudo tee --append /etc/dhcpcd.conf
sudo echo static ip_address=$NEWETH_IP | sudo tee --append /etc/dhcpcd.conf
sudo echo static routers=$CURRENTETH_GATEWAY | sudo tee --append /etc/dhcpcd.conf
sudo echo static domain_name_servers=$CURRENTETH_GATEWAY | sudo tee --append /etc/dhcpcd.conf
sudo echo ## Wifi | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo network={ | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo ssid="$NEW_SSID" | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo psk=$NEW_PSK | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo } | sudo tee --append /etc/wpa_supplicant/wpa_supplicant.conf
sudo echo #wlan0 | sudo tee --append /etc/dhcpcd.conf
sudo echo interface wlan0 | sudo tee --append /etc/dhcpcd.conf
sudo echo static ip_address=$NEWWLAN_IP | sudo tee --append /etc/dhcpcd.conf
sudo echo static routers=$CURRENTWLAN_GATEWAY | sudo tee --append /etc/dhcpcd.conf
sudo echo static domain_name_servers=$CURRENTWLAN_GATEWAY | sudo tee --append /etc/dhcpcd.conf
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
{ whiptail --msgbox "I'm going to add sources" 20 70 1 
sudo mv /etc/apt/sources.list /home/backups/sources.list.default
sudo echo 'deb http://repozytorium.mati75.eu/raspbian jessie-backports main contrib non-free' | sudo tee --append /etc/apt/sources.list
sudo echo 'deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi' | sudo tee --append /etc/apt/sources.list.d/stretch.list
sudo echo 'APT::Default-Release \"jessie\";' | sudo tee --append /etc/apt/apt.conf.d/99-default-release
sudo gpg --keyserver pgpkeys.mit.edu --recv-key CCD91D6111A06851
sudo gpg --armor --export CCD91D6111A06851 | apt-key add -
sudo wget https://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -
 }
sudo apt-get install -y pv





## POSSIBLE INSTALL OF DNSCRYPT
#{ if (whiptail --yesno "Do you plan on using dnscrypt?" 8 78) then
#echo "Stay tuned"
#else
#echo ""
#fi }
