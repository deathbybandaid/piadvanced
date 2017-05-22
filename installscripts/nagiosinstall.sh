#!/bin/sh
## nagios

## apache
sudo apt-get install apache2

## user
useradd -m nagios
passwd nagios
/usr/sbin/groupadd nagcmd
/usr/sbin/usermod -a -G nagcmd nagios
/usr/sbin/usermod -a -G nagcmd www-data

## download
cd /tmp
sudo wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz
sudo wget http://www.nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz

## extract
sudo tar zxvf nagios-4.1.1.tar.gz
sudo tar zxvf nagios-plugins-2.1.1.tar.gz

## build and install
cd /tmp/nagios-4.1.1
sudo ./configure --with-command-group=nagcmd
sudo make all
sudo make install
sudo make install-init
sudo make install-config
sudo make install-commandmode
sudo install -c -m 644 sample-config/httpd.conf /etc/apache2/sites-enabled/nagios.conf
sudo mkdir /etc/httpd
sudo mkdir /etc/httpd/conf.d
sudo mkdir /etc/httpd/conf.d/nagios.conf
sudo make install-webconf
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
/etc/init.d/apache2 reload
cd /tmp/nagios-plugins-2.1.1
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios
sudo make
sudo make install
ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
cp -n /etc/piadvanced/installscripts/nagios.service /etc/systemd/system/nagios.service
mv /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/

## restart services
service apache2 restart
systemctl enable /etc/systemd/system/nagios.service
systemctl start nagios
