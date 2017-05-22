#!/bin/bash
## HASS

sudo apt-get --force-yes --yes install git
sudo apt-get --force-yes --yes install libssl-dev
sudo apt-get --force-yes --yes install libffi-dev
sudo apt-get --force-yes --yes remove apt-listchanges
sudo apt-get install -y build-essential
sudo apt-get install -y git
sudo apt-get install -y libssl-dev
sudo apt-get install -y cmake
sudo apt-get install -y libc-ares-dev
sudo apt-get install -y uuid-dev
sudo apt-get install -y daemon
sudo apt-get install -y curl
sudo apt-get install -y libgnutls28-dev
sudo apt-get install -y libgnutlsxx28
sudo apt-get install -y libgnutls-dev
sudo apt-get install -y nmap
sudo apt-get install -y net-tools
sudo apt-get install -y sudo
sudo apt-get install -y libglib2.0-dev
sudo apt-get install -y cython3
sudo apt-get install -y libudev-dev
sudo apt-get install -y libxrandr-dev
sudo apt-get install -y swig

## Clone repo
sudo git clone https://github.com/home-assistant/fabric-home-assistant.git /etc/piadvanced/fabric-home-assistant/

## go to directory
cd /etc/piadvanced/fabric-home-assistant

## remove reboot
sudo sed -i "s/reboot/#reboot/" /etc/piadvanced/fabric-home-assistant/fabfile.py

## do the things
fab deploy_novenv -H localhost 2>&1 | sudo tee installation_report.txt
