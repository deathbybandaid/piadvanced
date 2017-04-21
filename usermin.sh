#!/bin/sh
## Usermin
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Usermin?" 8 78) then
echo "User Declined Usermin"
else
sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl
sudo wget http://prdownloads.sourceforge.net/webadmin/usermin_1.701_all.deb
sudo dpkg --install usermin_1.701_all.deb
sudo echo "# Usermin" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 20000 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }
