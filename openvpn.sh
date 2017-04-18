#!/bin/sh
## OpenVPN
{ if (whiptail --yesno "Do you plan on using the OpenVPN Server?" 8 78) then
sudo wget https://raw.githubusercontent.com/Nyr/openvpn-install/master/openvpn-install.sh -P /etc/piadvanced/installscripts/
sudo chmod +x /etc/piadvanced/installscripts/openvpn-install.sh
sudo bash /etc/piadvanced/installscripts/openvpn-install.sh
else
echo ""
fi }
