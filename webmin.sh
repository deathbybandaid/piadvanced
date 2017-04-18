#!/bin/sh
## Webmin
{ if (whiptail --yesno "Do you want to install Webmin?" 8 78) then
sudo apt-get -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
sudo wget http://prdownloads.sourceforge.net/webadmin/webmin_1.831_all.deb
sudo dpkg --install webmin_1.831_all.deb
sudo echo "# Webmin" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 10000 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
else
echo ""
fi }
