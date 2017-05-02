#!/bin/sh
## OpenVPN

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you plan on using the OpenVPN Server?" 8 78) then
echo "User Declined OpenVPN"
else
whiptail --msgbox "Select TCP during the install" 20 70 1
sudo wget https://raw.githubusercontent.com/Nyr/openvpn-install/master/openvpn-install.sh -P /etc/piadvanced/installscripts/
sudo chmod +x /etc/piadvanced/installscripts/openvpn-install.sh
sudo bash /etc/piadvanced/installscripts/openvpn-install.sh
sudo echo "openvpnfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
sudo sed -i "s/push "dhcp-option DNS 8.8.8.8"/"dhcp-option DNS 10.8.0.1"/" /etc/openvpn/server.conf
fi }
