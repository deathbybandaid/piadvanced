#!/bin/sh
################################################################
##          This is The Deathbybandaid Pihole Install         ##
################################################################
##    This Must be run as root, or it fails is some places    ##
################################################################
#{ if (whiptail --yesno "Are you running as root?" 8 78) then
#echo ""
#else
#exit
#fi }
mkdir /home/installs
mkdir /home/backups
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
{ whiptail --msgbox "I'm going to run updates." 20 70 1 
sudo apt-get install -y
sudo apt-get update --fix-missing
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt-get clean
 }
{ whiptail --msgbox "I'm going to install some stuff." 20 70 1
sudo apt-get install raspi-config -y
sudo apt-get install -t stretch -y nginx-full
sudo apt-get install -t stretch -y php7.0
sudo apt-get install -t stretch -y php7.0-curl
sudo apt-get install -t stretch -y php7.0-gd
sudo apt-get install -t stretch -y php7.0-fpm
sudo apt-get install -t stretch -y php7.0-opcache
sudo apt-get install -t stretch -y php7.0-opcache
sudo apt-get install -t stretch -y php7.0-mbstring
sudo apt-get install -t stretch -y php7.0-xml 
sudo apt-get install -t stretch -y php7.0-zip
sudo apt-get install -y zip
sudo apt-get install -y unzip
sudo apt-get install -y build-essential
sudo apt-get install -y wget
sudo apt-get install -y checkinstall
sudo apt-get install -y fail2ban
sudo apt-get install -y git
sudo apt-get install -y install perl
sudo apt-get install -y libnet-ssleay-perl
sudo apt-get install -y openssl
sudo apt-get install -y libauthen-pam-perl
sudo apt-get install -y libpam-runtime
sudo apt-get install -y libio-p
sudo apt-get install -y ty-perl
sudo apt-get install -y apt-show-versions
sudo apt-get install -y python
sudo apt-get install -y dnsutils
sudo apt-get install -y rng-tools
sudo echo 'HRNGDEVICE=/dev/urandom' | sudo tee --append /etc/default/rng-tools
sudo apt-get install -y xrdp
sudo apt-get install -y python-pip
sudo apt-get install -y apt-utils
sudo apt-get install -y debconf
sudo apt-get install -y dhcpcd5
sudo apt-get install -y iproute
sudo apt-get install -y whiptail
sudo apt-get install -y bc
sudo apt-get install -y cron
sudo apt-get install -y curl
sudo apt-get install -y dnsmasq
sudo apt-get install -y iputils-ping
sudo apt-get install -y lsof
sudo apt-get install -y netcat
sudo apt-get install -y sudo
sudo apt-get install -y lighttpd
 }
{ whiptail --msgbox "During the install, Apache2 was installed, to make sure that it doesn't interfere with port 80 for pihole, I am changing the ports now" 20 70 1
sudo sed -i 's/80/85/' /etc/apache2/ports.conf
sudo sed -i 's/80/85/' /etc/apache2/sites-enabled/000-default.conf
sudo sed -i 's/443/445/' /etc/apache2/ports.conf
sudo sed -i 's/443/445/' /etc/apache2/sites-enabled/000-default.conf
 }
## POSSIBLE INSTALL OF DNSCRYPT
#{ if (whiptail --yesno "Do you plan on using dnscrypt?" 8 78) then
#echo "Stay tuned"
#else
#echo ""
#fi }
{ if (whiptail --yesno "Do you plan on using the No-IP dynamic Update Client?" 8 78) then
sudo mkdir /home/installs/noip
sudo wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz -P /home/installs/noip/
cd /home/installs/noip/
sudo tar vzxf noip-duc-linux.tar.gz
cd /home/installs/noip/noip-2.1.9-1/
sudo make
sudo make install
sudo /usr/local/bin/noip2
sudo noip2 ­-S
else
echo ""
fi }
{ if (whiptail --yesno "Do you plan on using the OpenVPN Server?" 8 78) then
sudo wget https://raw.githubusercontent.com/Nyr/openvpn-install/master/openvpn-install.sh -P /home/installs/
sudo chmod +x /home/installs/openvpn-install.sh
sudo bash /home/installs/openvpn-install.sh
else
echo ""
fi }
{ if (whiptail --yesno "Do you plan on using the Pihole Software?" 8 78) then
cd /home/pi/installs
sudo git clone --depth 1 https://github.com/pi-hole/pi-hole.git Pi-hole
cd Pi-hole/automated\ install/
bash basic-install.sh
else
echo ""
fi }
{ whiptail --msgbox " This is to change pihole password" 20 70 1
  NEW_PASS=$(whiptail --inputbox "Please enter a password" 20 60 "" 3>&1 1>&2 2>&3)
  if [ $? -eq 0 ]; then pihole -a -p $NEW_PASS
fi }
{ whiptail --msgbox "Installing some dnsmasq tweaks. See Readme" 20 70 1
sudo wget https://raw.githubusercontent.com/deathbybandaid/pihole-bypass/master/04-bypass.conf -P /etc/dnsmasq.d/
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeinterfaces/master/05-addint.conf -P /etc/dnsmasq.d/
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeAD/master/06-activedirectory.conf -P /etc/dnsmasq.d/
 }
