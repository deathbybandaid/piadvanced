#!/bin/sh
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
sudo systemctl enable nginx
fi  }
else
echo ""
fi }

## openssl 
sudo openssl dhparam -out /etc/nginxdh2048.pem 2048

## Perfect forward secrecy
sudo echo "ssl_ciphers "ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS";" | sudo tee --append /etc/nginxperfect-forward-secrecy.conf
sudo echo "ssl_dhparam /etc/nginx/dh2048.pem;" | sudo tee --append /etc/nginxperfect-forward-secrecy.conf
sudo echo "add_header Strict-Transport-Security "max-age=31536000; includeSubdomains;";" | sudo tee --append /etc/nginxperfect-forward-secrecy.conf

## Let's Encrypt
sudo bash /etc/piadvanced/letsencrypt.sh
