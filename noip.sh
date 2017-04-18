## No-IP
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
