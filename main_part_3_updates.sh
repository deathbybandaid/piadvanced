#!/bin/sh
{ whiptail --msgbox "I'm going to add sources ." 20 70 1 
sudo cp /etc/apt/sources.list /home/backups/sources.list.default
sudo echo 'deb http://repozytorium.mati75.eu/raspbian jessie-backports main contrib non-free' | sudo tee --append /etc/apt/sources.list
sudo echo 'deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi' | sudo tee --append /etc/apt/sources.list.d/stretch.list
sudo echo 'APT::Default-Release "jessie";' | sudo tee --append /etc/apt/apt.conf.d/99-default-release
sudo gpg --keyserver pgpkeys.mit.edu --recv-key CCD91D6111A06851
sudo gpg --armor --export CCD91D6111A06851 | apt-key add -
sudo wget https://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -
 }
{ whiptail --msgbox "I'm going to run updates." 20 70 1 
sudo apt-get install -y
sudo apt-get update --fix-missing
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt-get clean
 }
{ whiptail --msgbox "I'm going to install some stuff." 20 70 1
sudo apt-get install raspi-config -y
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
sudo apt-get install -y dnsmasq
sudo apt-get install -y iputils-ping
sudo apt-get install -y lsof
sudo apt-get install -y netcat
sudo apt-get install -y sudo
 }
