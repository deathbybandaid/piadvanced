## Lighttpd
{
source /home/dbbvariables
LIGHT_BIND=`sed -n '/server.port                 = 80/=' /etc/lighttpd/lighttpd.conf`
whiptail --msgbox "What ports do you want Lighttpd to use?" 20 70 1
whiptail --msgbox "I suggest setting port 80 to the static ip of wlan0" 20 70 1
NEW_LIGHTTPDBIND=$(whiptail --inputbox "Add server.bind for the wlan lighttpd" 20 60 "$NEWETH_IP" 3>&1 1>&2 2>&3)
NEW_LIGHTTPD80=$(whiptail --inputbox "Change the default port 80 for lighttpd" 20 60 "80" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo sed -i "$LIGHT_BIND a\server.bind                 = "$NEW_LIGHTTPDBIND"" /etc/lighttpd/lighttpd.conf
sudo sed -i "s/80/$NEW_LIGHTTPD80/" /etc/lighttpd/lighttpd.conf
fi  }
