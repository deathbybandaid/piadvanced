#!/bin/sh
## These are the python installs
## and pips

## python
sudo apt-get --force-yes --yes install python-dev
sudo apt-get --force-yes --yes install python-pip

## python3
sudo apt-get install -t stretch -y python3-dev
sudo apt-get install -t stretch -y python3-pip
sudo apt-get install -y python3-sphinx
sudo apt-get install -y python3-setuptools

## pip
sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip install pycrypto
sudo pip install cryptography
sudo pip install packaging
sudo pip install appdirs
sudo pip install six
sudo pip install fabric

## pip3
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install --upgrade setuptools
sudo python3 -m pip install pycrypto
sudo python3 -m pip install cryptography
sudo python3 -m pip install packaging
sudo python3 -m pip install six
sudo python3 -m pip install appdirs
sudo python3 -m pip install fabric
