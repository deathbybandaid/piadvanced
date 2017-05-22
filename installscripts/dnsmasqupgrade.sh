#!/bin/bash

# first update & upgrade the system from STABLE
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq upgrade

# create the required files (4) to allow updgrade/install from STRETCH
# create /etc/apt/preferences.d/jessie.pref
echo "Package: *
Pin: release a=jessie
Pin-Priority: 900" > /etc/apt/preferences.d/jessie.pref
# create /etc/apt/preferences.d/stretch.pref
echo "Package: *
Pin: release a=stretch
Pin-Priority: 750" > /etc/apt/preferences.d/stretch.pref
# create /etc/apt/sources.list.d/jessie.list
echo "deb http://mirrordirector.raspbian.org/raspbian/ jessie main contrib non-free rpi" > /etc/apt/sources.list.d/jessie.list
# create /etc/apt/sources.list.d/stretch.list
echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" > /etc/apt/sources.list.d/stretch.list

# run sudo apt-get update to allow updgrade/install from STRETCH
sudo apt-get update

# install build-essential from STRETCH
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install build-essential -t stretch

# install necessary system packages for dnsmasq from STRETCH
sudo apt-get -y install gettext -t stretch
sudo apt-get -y install libnetfilter-conntrack-dev -t stretch
sudo apt-get -y install libidn11-dev -t stretch
sudo apt-get -y install libdbus-1-dev -t stretch
sudo apt-get -y install libgmp-dev -t stretch
sudo apt-get -y install nettle-dev -t stretch

# remove the (4) files that allow upgrade/install from STRETCH
sudo rm /etc/apt/preferences.d/jessie.pref
sudo rm /etc/apt/preferences.d/stretch.pref
sudo rm /etc/apt/sources.list.d/jessie.list
sudo rm /etc/apt/sources.list.d/stretch.list

# run sudo apt-get update to allow updgrade/install from STABLE
sudo apt-get update

# cleanup
sudo apt-get -y autoremove

# dnsmasq
file=dnsmasq-2.77test4
mkdir -p dnsmasq
cd dnsmasq
wget http://www.thekelleys.org.uk/dnsmasq/test-releases/$file.tar.gz
tar xzf $file.tar.gz
cd $file
fakeroot debian/rules binary
cd ..
sudo dpkg -i dnsmasq*.deb
cd ..
