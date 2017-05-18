#!/bin/sh
## This will update the notracking files

sudo rm /etc/piadvanced/piholetweaks/notracking/hostnames.txt
sudo rm /etc/piadvanced/piholetweaks/notracking/domains.txt
sudo wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt -P /etc/piadvanced/piholetweaks/notracking/
sudo wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/domains.txt -P /etc/piadvanced/piholetweaks/notracking/
sudo service dnsmasq restart
