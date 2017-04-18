##Usermin
## 
{ if (whiptail --yesno "Do you want to install Usermin?" 8 78) then
sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl
wget http://prdownloads.sourceforge.net/webadmin/usermin_1.701_all.deb
dpkg --install usermin_1.701_all.deb
else
echo ""
fi }
