#!/bin/sh
## Let'sencrypt
#sudo git clone https://github.com/certbot/certbot /etc/letsencrypt
#sudo /etc/letsencrypt/certbot-auto certonly --agree-tos --webroot -w /data/mysite.com/www -d mysite.com -d www.mysite.com -d mail.mysite.com -d srv01.mysite.com

# 0 6 * * * /etc/letsencrypt/certbot/certbot-auto renew --text >> /etc/letsencrypt/certbot/certbot-cron.log && sudo service nginx reload

