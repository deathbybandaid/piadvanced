#!/bin/sh

[ -f "/var/phbp.ini" ] && sudo mv /var/phbp.ini /var/phbp.ini.BAK
html=$(grep server.document-root /etc/lighttpd/lighttpd.conf | awk -F\" '{print $2}')
sudo wget -q https://raw.githubusercontent.com/WaLLy3K/Pi-hole-Block-Page/master/index.php -O "$html/index.php"
sudo wget -q https://raw.githubusercontent.com/WaLLy3K/Pi-hole-Block-Page/master/phbp.ini -O "/var/phbp.ini"
sudo chmod 755 "$html/index.php"
[ -f "/var/phbp.php" ] && sudo mv /var/phbp.php /var/phbp.old.BAK
[ ! -d "/etc/lighttpd/conf-enabled" ] && sudo mkdir -m 755 /etc/lighttpd/conf-enabled
[ ! -f "/etc/lighttpd/conf-enabled/phbp.conf" ] && echo -e '# Pi-hole "server.error-handler-404" override\nurl.rewrite-once = ( "pihole/index.php" => "/index.php" )' | sudo tee /etc/lighttpd/conf-enabled/phbp.conf
echo "Done! Please edit '/var/phbp.ini' to customise your install"
sudo service lighttpd force-reload
