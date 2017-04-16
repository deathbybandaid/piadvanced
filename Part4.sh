#!/bin/sh
{ whiptail --msgbox "During the install, multiple webservers were installed. Let's try to adjust the configs to not interfere with eachother" 20 70 1
source /home/dbbvariables
LIGHT_BIND=`sed -n '/server.port                 = 80/=' /etc/lighttpd/lighttpd.conf`
whiptail --msgbox "If these aren't set correctly, you will have to manually adjust them, because they may not start properly." 20 70 1
whiptail --msgbox "What ports do you want Apache to use?" 20 70 1
whiptail --msgbox "I suggest changing Apache Ports to something like 85 and 445" 20 70 1
NEW_APACHE80=$(whiptail --inputbox "Change the default port 80 for Apache" 20 60 "85" 3>&1 1>&2 2>&3)
NEW_APACHE443=$(whiptail --inputbox "Change the default port 443 for Apache" 20 60 "445" 3>&1 1>&2 2>&3)
whiptail --msgbox "What ports do you want NGINX to use?" 20 70 1
whiptail --msgbox "I suggest setting port 80 to the static ip of eth0" 20 70 1
NEW_NGINX80=$(whiptail --inputbox "Change the default port 80 for Nginx" 20 60 "$NEWETH_IP:80" 3>&1 1>&2 2>&3)
whiptail --msgbox "What ports do you want Lighttpd to use?" 20 70 1
whiptail --msgbox "I suggest setting port 80 to the static ip of wlan0" 20 70 1
NEW_LIGHTTPDBIND=$(whiptail --inputbox "Add server.bind for the wlan lighttpd" 20 60 "$NEWETH_IP" 3>&1 1>&2 2>&3)
NEW_LIGHTTPD80=$(whiptail --inputbox "Change the default port 80 for lighttpd" 20 60 "80" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo echo "NEW_APACHE80=$NEW_APACHE80" | sudo tee --append /home/dbbvariables
sudo echo "NEW_APACHE443=$NEW_APACHE443" | sudo tee --append /home/dbbvariables
sudo echo "NEW_NGINX80=$NEW_NGINX80" | sudo tee --append /home/dbbvariables
sudo sed -i "s/80/$NEW_APACHE80/" /etc/apache2/ports.conf
sudo sed -i "s/80/$NEW_APACHE80/" /etc/apache2/sites-enabled/000-default.conf
sudo sed -i "s/443/$NEW_APACHE443/" /etc/apache2/ports.conf
sudo sed -i "s/443/$NEW_APACHE443/" /etc/apache2/sites-enabled/000-default.conf
sudo sed -i "s/listen 80 default_server/listen $NEW_NGINX80 default_server/" /etc/nginx/sites-available/default
sudo sed -i "$LIGHT_BIND a\server.bind                 = "$NEW_LIGHTTPDBIND"" /etc/lighttpd/lighttpd.conf
sudo sed -i "s/80/$NEW_LIGHTTPD80/" /etc/lighttpd/lighttpd.conf
sudo service nginx restart
sudo service apache2 restart
sudo service lighttpd restart
fi  }
