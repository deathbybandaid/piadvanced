## OpenVPN
{ if (whiptail --yesno "Do you plan on using the OpenVPN Server?" 8 78) then
sudo wget https://raw.githubusercontent.com/Nyr/openvpn-install/master/openvpn-install.sh -P /home/installs/
sudo chmod +x /home/installs/openvpn-install.sh
sudo bash /home/installs/openvpn-install.sh
else
echo ""
fi }
