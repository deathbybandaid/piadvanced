## NGINX
{ if (whiptail --yesno "Do you plan on running Nginx" 8 78) then
{
source /home/dbbvariables
whiptail --msgbox "What ports do you want NGINX to use?" 20 70 1
whiptail --msgbox "I suggest setting port 80 to the static ip of eth0" 20 70 1
NEW_NGINX80=$(whiptail --inputbox "Change the default port 80 for Nginx" 20 60 "$NEWETH_IP:80" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo apt-get install -t stretch -y nginx-full
sudo cp -r /etc/nginx/ /etc/piadvanced/backups/nginx/
sudo echo "NEW_NGINX80=$NEW_NGINX80" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo sed -i "s/listen 80 default_server/listen $NEW_NGINX80 default_server/" /etc/nginx/sites-available/default
fi  }
else
echo ""
fi }
