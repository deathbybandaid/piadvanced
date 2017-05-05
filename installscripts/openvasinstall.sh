#!/bin/sh
## Openvas

sudo apt-get install -y build-essential
sudo apt-get install -y cmake
sudo apt-get install -y bison
sudo apt-get install -y flex
sudo apt-get install -y libpcap-dev
sudo apt-get install -y pkg-config
sudo apt-get install -y libgnutls-dev
sudo apt-get install -y libglib2.0-dev
sudo apt-get install -y libgpgme11-dev
sudo apt-get install -y uuid-dev
sudo apt-get install -y sqlfairy
sudo apt-get install -y xmltoman
sudo apt-get install -y doxygen
sudo apt-get install -y libssh-dev
sudo apt-get install -y libksba-dev
sudo apt-get install -y libldap2-dev
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y libmicrohttpd-dev
sudo apt-get install -y libxml2-dev
sudo apt-get install -y libxslt1-dev
sudo apt-get install -y xsltproc
sudo apt-get install -y clang
sudo apt-get install -y rsync
sudo apt-get install -y rpm
sudo apt-get install -y nsis
sudo apt-get install -y alien
sudo apt-get install -y sqlite3
cd ~
sudo wget http://wald.intevation.org/frs/download.php/2031/openvas-libraries-7.0.10.tar.gz
sudo tar xvf openvas-libraries-7.0.10.tar.gz
cd openvas-libraries-7.0.10
sudo cmake .
sudo make
sudo make doc
sudo make install
cd ~
sudo wget http://wald.intevation.org/frs/download.php/1959/openvas-scanner-4.0.6.tar.gz
sudo tar xvf openvas-scanner-4.0.6.tar.gz
cd openvas-scanner-4.0.6
sudo cmake .
sudo make 
sudo make doc
sudo make install
cd ~
sudo wget http://wald.intevation.org/frs/download.php/2035/openvas-manager-5.0.10.tar.gz
sudo tar xvf openvas-manager-5.0.10.tar.gz
cd openvas-manager-5.0.10
sudo cmake .
sudo make
sudo make doc
sudo make install
cd ~
sudo wget http://wald.intevation.org/frs/download.php/2039/greenbone-security-assistant-5.0.7.tar.gz
sudo tar xvf greenbone-security-assistant-5.0.7.tar.gz
cd greenbone-security-assistant-5.0.7
sudo cmake .
sudo make
sudo make doc
sudo make install
cd ~
sudo wget http://wald.intevation.org/frs/download.php/1803/openvas-cli-1.3.1.tar.gz
sudo tar xvf openvas-cli-1.3.1.tar.gz
cd openvas-cli-1.3.1
sudo cmake .
sudo make
sudo make doc
sudo make install
sudo ldconfig
cd ~
sudo wget --no-check-certificate https://svn.wald.intevation.org/svn/openvas/trunk/tools/openvas-check-setup
sudo chmod +x openvas-check-setup
sudo ./openvas-check-setup --v7
sudo openvas-mkcert
sudo openvas-nvt-sync
sudo openvas-scapdata-sync
sudo openvas-certdata-sync
sudo openvas-mkcert-client -n -i
sudo apt-get install gnupg
sudo wget http://www.openvas.org/OpenVAS_TI.asc
sudo gpg --homedir=/usr/local/etc/openvas/gnupg --import OpenVAS_TI.asc
sudo gpg --homedir=/usr/local/etc/openvas/gnupg --lsign-key 48DB4530
sudo echo "nasl_no_signature_check = no" >> /usr/local/etc/openvas/openvassd.conf
sudo wget http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xml
sudo openvas-portnames-update service-names-port-numbers.xml
sudo rm service-names-port-numbers.xml
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
cd ~ &&
sudo wget --no-check-certificate https://sourceforge.net/projects/openvasvm/files/openvasd/download && cp openvasd /etc/init.d/ && update-rc.d openvasd defaults
