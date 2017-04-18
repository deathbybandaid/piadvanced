#!/bin/sh
## Webmin
{ if (whiptail --yesno "Do you want to install Webmin?" 8 78) then
sudo apt-get -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
sudo wget http://prdownloads.sourceforge.net/webadmin/webmin_1.831_all.deb
sudo dpkg --install webmin_1.831_all.deb
else
echo ""
fi }
