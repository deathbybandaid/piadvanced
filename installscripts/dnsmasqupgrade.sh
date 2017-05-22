#!/bin/bash

# first update & upgrade the system from STABLE
sudo apt-get update
sudo apt-get -y upgrade

# run sudo apt-get update to allow updgrade/install from STRETCH
sudo apt-get update

# install build-essential from STRETCH
sudo apt-get -y -t stretch install build-essential

# install necessary system packages for dnsmasq from STRETCH
sudo apt-get -y -t stretch install gettext
sudo apt-get -y -t stretch install libnetfilter-conntrack-dev 
sudo apt-get -y -t stretch install libidn11-dev
sudo apt-get -y -t stretch install libdbus-1-dev
sudo apt-get -y -t stretch install libgmp-dev
sudo apt-get -y -t stretch install nettle-dev

# run sudo apt-get update to allow updgrade/install from STABLE
sudo apt-get update

# cleanup
sudo apt-get -y autoremove

# dnsmasq
mkdir -p dnsmasq
cd dnsmasq
wget http://www.thekelleys.org.uk/dnsmasq/test-releases/dnsmasq-2.77test4.tar.gz
tar xzf dnsmasq-2.77test4.tar.gz
cd dnsmasq-2.77test4
fakeroot debian/rules binary
cd ..
sudo dpkg -i dnsmasq*.deb
cd ..
