#!/bin/sh
## Dependencies
NAMEOFAPP="dependencies"
WHATITDOES="These are programs that are a foundation for other softwares. Skipping could be fatal."

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 8 78) 
then
echo "$CURRENTUSER Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=no" | sudo tee --append /etc/piadvanced/install/variables.conf
else
echo "$CURRENTUSER Accepted $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=yes" | sudo tee --append /etc/piadvanced/install/variables.conf

## Below here is the magic.
sudo apt-get install -y raspi-config
sudo apt-get install -y apt-transport-https 
sudo apt-get install -y gawk
sudo apt-get install -y tcpdump
sudo apt-get install -t stretch libio-pty-perl -y
sudo apt-get install -y libsodium-dev
sudo apt-get install -y locate 
sudo apt-get install -y bash-completion
sudo apt-get install -y bundler
sudo apt-get install -y nodejs
sudo apt-get install -y libsystemd-dev
sudo apt-get install -y zip
sudo apt-get install -y unzip
sudo apt-get install -y build-essential
sudo apt-get install -y wget
sudo apt-get install -y checkinstall
sudo apt-get install -y git
sudo apt-get install -y install perl
sudo apt-get install -y libnet-ssleay-perl
sudo apt-get install -y openssl
sudo apt-get install -y libauthen-pam-perl
sudo apt-get install -y libpam-runtime
sudo apt-get install -y libio-p
sudo apt-get install -y ty-perl
sudo apt-get install -y apt-show-versions
sudo apt-get install -y python
sudo apt-get install -y dnsutils
sudo apt-get install -t stretch -y php7.0
sudo apt-get install -t stretch -y php7.0-curl
sudo apt-get install -t stretch -y php7.0-gd
sudo apt-get install -t stretch -y php7.0-fpm
sudo apt-get install -t stretch -y php7.0-opcache
sudo apt-get install -t stretch -y php7.0-opcache
sudo apt-get install -t stretch -y php7.0-mbstring
sudo apt-get install -t stretch -y php7.0-xml 
sudo apt-get install -t stretch -y php7.0-zip
sudo apt-get install -y python-pip
sudo apt-get install -y apt-utils
sudo apt-get install -y debconf
sudo apt-get install -y dhcpcd5
sudo apt-get install -y iproute
sudo apt-get install -y whiptail
sudo apt-get install -y bc
sudo apt-get install -y cron
sudo apt-get install -y curl
sudo apt-get install -y iputils-ping
sudo apt-get install -y lsof
sudo apt-get install -y netcat
sudo apt-get install -y sudo
sudo systemctl enable php7.0-fpm
sudo apt-get -t stretch -y install libcairo2-dev
sudo apt-get -t stretch -y install libjpeg-turbo8-dev
sudo apt-get -t stretch -y install libpng12-dev
sudo apt-get -t stretch -y install libossp-uuid-dev
sudo apt-get -t stretch -y install libavcodec-dev
sudo apt-get -t stretch -y install libavutil-dev
sudo apt-get -t stretch -y install libswscale-dev
sudo apt-get -t stretch -y install libfreerdp-dev
sudo apt-get -t stretch -y install libpango1.0-dev
sudo apt-get -t stretch -y install libssh2-1-dev
sudo apt-get -t stretch -y install libtelnet-dev
sudo apt-get -t stretch -y install libvncserver-dev
sudo apt-get -t stretch -y install libpulse-dev
sudo apt-get -t stretch -y install libssl-dev
sudo apt-get -t stretch -y install libvorbis-dev
sudo apt-get -t stretch -y install libwebp-dev
sudo apt-get -t stretch -y install mysql-server
sudo apt-get -t stretch -y install mysql-client
sudo apt-get -t stretch -y install mysql-common
sudo apt-get -t stretch -y install mysql-utilities
sudo apt-get -t stretch -y install tomcat8
sudo apt-get -t stretch -y install freerdp
sudo apt-get -t stretch -y install ghostscript
sudo apt-get -t stretch -y install jq
sudo apt-get install -y dos2unix
sudo apt-get install -y libsodium-dev
sudo apt-get install -y locate
sudo apt-get install -y bash-completion
sudo apt-get install -y libsystemd-dev
sudo apt-get install -y pkg-config

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
