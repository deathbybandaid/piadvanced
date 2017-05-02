#!/bin/bash
## HASS

me=$(whoami)
sudo apt-get --force-yes --yes install python-dev
sudo apt-get --force-yes --yes install python-pip
sudo apt-get --force-yes --yes install git
sudo apt-get --force-yes --yes install libssl-dev
sudo apt-get --force-yes --yes install libffi-dev
sudo apt-get --force-yes --yes remove apt-listchanges
sudo apt-get install -y python3-pip
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install --upgrade setuptools
sudo python3 -m pip install pycrypto
sudo python3 -m pip install cryptography
sudo python3 -m pip install packaging
sudo python3 -m pip install six
sudo python3 -m pip install fabric
sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip install pycrypto
sudo pip install cryptography
sudo pip install packaging
sudo pip install appdirs
sudo pip install six
sudo pip install fabric
sudo git clone https://github.com/home-assistant/fabric-home-assistant.git /etc/piadvanced/fabric-home-assistant/
cd /etc/piadvanced/fabric-home-assistant
fab deploy_novenv -H localhost 2>&1 | sudo tee installation_report.txt
