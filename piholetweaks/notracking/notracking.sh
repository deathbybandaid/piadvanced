#!/bin/sh
## This will update the notracking files

sudo rm /etc/piadvanced/piholetweaks/notracking/hostnames.txt
sudo rm /etc/piadvanced/piholetweaks/notracking/domains.txt
sudo rm /etc/dnsmasq.d/11-notracking.conf
sudo cp /etc/piadvanced/piholetweaks/notracking/11-notracking.conf /etc/dnsmasq.d/
sudo wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt -P /etc/piadvanced/piholetweaks/notracking/
sudo wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/domains.txt -P /etc/piadvanced/piholetweaks/notracking/
sudo service dnsmasq restart
