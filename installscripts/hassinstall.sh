#!/bin/bash
## HASS

sudo apt-get --force-yes --yes install python-dev
sudo apt-get --force-yes --yes install python-pip
sudo apt-get --force-yes --yes install git
sudo apt-get --force-yes --yes install libssl-dev
sudo apt-get --force-yes --yes install libffi-dev
sudo apt-get --force-yes --yes remove apt-listchanges
sudo apt-get install -t stretch -y python3-dev
sudo apt-get install -t stretch -y python3-pip
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install --upgrade setuptools
sudo python3 -m pip install pycrypto
sudo python3 -m pip install cryptography
sudo python3 -m pip install packaging
sudo python3 -m pip install six
sudo python3 -m pip install appdirs
sudo python3 -m pip install fabric
sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip install pycrypto
sudo pip install cryptography
sudo pip install packaging
sudo pip install appdirs
sudo pip install six
sudo pip install fabric
sudo apt-get install  -y build-essential
sudo apt-get install  -y python-pip
sudo apt-get install  -y python-dev
sudo apt-get install  -y python3
sudo apt-get install  -y python3-dev
sudo apt-get install  -y python3-pip
sudo apt-get install  -y python3-sphinx
sudo apt-get install  -y python3-setuptools
sudo apt-get install  -y git
sudo apt-get install  -y libssl-dev
sudo apt-get install  -y cmake
sudo apt-get install  -y libc-ares-dev
sudo apt-get install  -y uuid-dev
sudo apt-get install  -y daemon
sudo apt-get install  -y curl
sudo apt-get install  -y libgnutls28-dev
sudo apt-get install  -y libgnutlsxx28
sudo apt-get install  -y libgnutls-dev
sudo apt-get install  -y nmap
sudo apt-get install  -y net-tools
sudo apt-get install  -y sudo
sudo apt-get install  -y libglib2.0-dev
sudo apt-get install  -y cython3
sudo apt-get install  -y libudev-dev
sudo apt-get install  -y libxrandr-dev
sudo apt-get install  -y swig
sudo git clone https://github.com/home-assistant/fabric-home-assistant.git /etc/piadvanced/fabric-home-assistant/
cd /etc/piadvanced/fabric-home-assistant
fab deploy_novenv -H localhost 2>&1 | sudo tee installation_report.txt
