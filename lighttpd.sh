#!/bin/sh
## Lighttpd
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you plan on running Lighttpd" 8 78) then
echo "User Decline Lighttpd"
else
{
source /etc/piadvanced/install/variables.conf
LIGHT_BIND=`sed -n '/server.port                 = 80/=' /etc/lighttpd/lighttpd.conf`
whiptail --msgbox "What ports do you want Lighttpd to use?" 20 70 1
whiptail --msgbox "I suggest setting port 80 to the static ip of wlan0" 20 70 1
NEW_LIGHTTPDBIND=$(whiptail --inputbox "Add server.bind for the wlan lighttpd" 20 60 "$NEWETH_IP" 3>&1 1>&2 2>&3)
NEW_LIGHTTPD80=$(whiptail --inputbox "Change the default port 80 for lighttpd" 20 60 "80" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo apt-get install -y lighttpd
sudo echo "NEW_LIGHTTPDBIND=$NEW_LIGHTTPDBIND" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "NEW_LIGHTTPD80=$NEW_LIGHTTPD80" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo cp -r /etc/lighttpd/ /etc/piadvanced/backups/lighttpd/
sudo sed -i "$LIGHT_BIND a\server.bind                 = "$NEW_LIGHTTPDBIND"" /etc/lighttpd/lighttpd.conf
sudo sed -i "s/80/$NEW_LIGHTTPD80/" /etc/lighttpd/lighttpd.conf
sudo echo "# Lighttpd" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 83 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi  }
fi }
