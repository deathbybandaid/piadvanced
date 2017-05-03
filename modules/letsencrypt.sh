#!/bin/sh
## Let'sencrypt

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

#sudo git clone https://github.com/certbot/certbot /etc/letsencrypt
#sudo /etc/letsencrypt/certbot-auto certonly --agree-tos --webroot -w /data/mysite.com/www -d mysite.com -d www.mysite.com -d mail.mysite.com -d srv01.mysite.com

#(crontab -l ; echo "0 6 * * * /etc/letsencrypt/certbot/certbot-auto renew --text >> /etc/letsencrypt/certbot/certbot-cron.log && sudo service nginx reload") | crontab -
