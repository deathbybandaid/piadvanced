#!/bin/sh
## php

sudo apt-get install -t stretch -y php7.0
sudo apt-get install -t stretch -y php7.0-curl
sudo apt-get install -t stretch -y php7.0-gd
sudo apt-get install -t stretch -y php7.0-fpm
sudo apt-get install -t stretch -y php7.0-opcache
sudo apt-get install -t stretch -y php7.0-opcache
sudo apt-get install -t stretch -y php7.0-mbstring
sudo apt-get install -t stretch -y php7.0-xml 
sudo apt-get install -t stretch -y php7.0-zip
sudo systemctl enable php7.0-fpm
