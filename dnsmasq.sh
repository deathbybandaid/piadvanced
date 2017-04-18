## POSSIBLE INSTALL OF DNSCRYPT
{ if (whiptail --yesno "Do you plan on using dnsmasq?" 8 78) then
{ if (whiptail --yesno "Do you want to use the experimenta version 2.77test4?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/dnsmasqUpdate/master/dnsmasqupgrade.sh -P /etc/piadvanced/installscripts/
sudo bash /etc/piadvanced/installscripts/dnsmasqupgrade.sh
else
sudo apt-get install -y dnsmasq
fi }
else
echo ""
fi }
