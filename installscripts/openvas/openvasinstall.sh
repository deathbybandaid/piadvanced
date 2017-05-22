#!/bin/sh
## Openvas

## Download packages
cd /etc/piadvanced/installscripts/openvas/
sudo wget http://wald.intevation.org/frs/download.php/2031/openvas-libraries-7.0.10.tar.gz
sudo wget http://wald.intevation.org/frs/download.php/1959/openvas-scanner-4.0.6.tar.gz
sudo wget http://wald.intevation.org/frs/download.php/2035/openvas-manager-5.0.10.tar.gz
sudo wget http://wald.intevation.org/frs/download.php/2039/greenbone-security-assistant-5.0.7.tar.gz
sudo wget http://wald.intevation.org/frs/download.php/1803/openvas-cli-1.3.1.tar.gz

## Set File Directory
FILES=/etc/piadvanced/installscripts/openvas/*.tar.gz

## Start File Loop
for f in $FILES
do
cd /etc/piadvanced/installscripts/openvas/
sudo tar xvf $f -C /etc/piadvanced/installscripts/openvas/"$f"extracted/
sudo rm $f
cd /etc/piadvanced/installscripts/openvas/"$f"extracted/
sudo cmake .
sudo make
sudo make doc
sudo make install
sudo ldconfig
## End File Loop
done

## certificate
cd ~
sudo chmod +x openvas-check-setup
sudo ./openvas-check-setup --v7
sudo openvas-mkcert
sudo openvas-nvt-sync
sudo openvas-scapdata-sync
sudo openvas-certdata-sync
sudo openvas-mkcert-client -n -i

## Setup
sudo echo "nasl_no_signature_check = no" >> /usr/local/etc/openvas/openvassd.conf
sudo wget http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xml
sudo openvas-portnames-update service-names-port-numbers.xml
sudo rm service-names-port-numbers.xml

## nmap
sudo wget http://nmap.org/dist/nmap-5.51.6.tgz
sudo tar xvf nmap-5.51.6.tgz
cd nmap-5.51.6
sudo ./configure
sudo make
sudo make install
sudo openvassd
sudo openvasmd --rebuild --progress
sudo openvassd
sudo openvasmd
sudo gsad
sudo openvasmd --create-user=admin --role=Admin

## almost done
cd ~
cp openvasd /etc/init.d/ 
update-rc.d openvasd defaults
