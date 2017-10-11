#!/bin/sh
## NGINX
NAMEOFAPP="nginx"
WHATITDOES="NGINX is a free, open-source, high-performance HTTP server, reverse proxy, and IMAP/POP3 proxy server."

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 10 80) 
then
echo "$CURRENTUSER Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=no" | sudo tee --append /etc/piadvanced/install/variables.conf
else
echo "$CURRENTUSER Accepted $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=yes" | sudo tee --append /etc/piadvanced/install/variables.conf

## Below here is the magic.
whiptail --msgbox "What ports do you want NGINX to use?" 10 80 1
whiptail --msgbox "I suggest setting port 80 to the static ip of eth0" 10 80 1
NEW_NGINX80=$(whiptail --inputbox "Change the default port 80 for Nginx" 10 80 "$NEWETH_IP:80" 3>&1 1>&2 2>&3)
sudo apt-get install -t stretch -y nginx-full
sudo cp -r /etc/nginx/ /etc/piadvanced/backups/nginx/
sudo echo "NEW_NGINX80=$NEW_NGINX80" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo sed -i "s/listen 80 default_server/listen $NEW_NGINX80 default_server/" /etc/nginx/sites-available/default
sudo systemctl enable nginx

## openssl 
{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to generate an Openssl key?" 10 80) 
then
sudo echo "User Declined Nginx Openssl."
else
sudo openssl dhparam -out /etc/nginxdh2048.pem 2048
fi }

## Perfect forward secrecy
{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use perfect forward secrecy with nginx" 10 80) 
then
sudo echo "User Declined Perfect Forward Secrecy"
else
sudo echo "ssl_ciphers "ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS";" | sudo tee --append /etc/nginx/perfect-forward-secrecy.conf
sudo echo "ssl_dhparam /etc/nginx/dh2048.pem;" | sudo tee --append /etc/nginx/perfect-forward-secrecy.conf
sudo echo "add_header Strict-Transport-Security "max-age=31536000; includeSubdomains;";" | sudo tee --append /etc/nginx/perfect-forward-secrecy.conf
fi }


## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
