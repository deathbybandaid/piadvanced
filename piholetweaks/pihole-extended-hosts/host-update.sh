#!/bin/bash
# update the host blocklist
sudo rm /var/www/html/lists/extended.txt
cd /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist
sudo git pull

# update the hosts blocklist
./makeHosts

# dedupe the generated blocklist against the pihole gravity list
echo "" > hosts2
GRAVITY=`cat /etc/pihole/gravity.list`
HOSTS=`cat /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist/hosts`

sudo cat /etc/pihole/gravity.list /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist/hosts >> /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist/hosts2
echo -e "\t`wc -l /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist/hosts2 | cut -d " " -f 1` lines after deduping"
rm -f /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist/hosts
sudo cat /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist/hosts2 >> /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist/hosts
sudo cp -n /etc/piadvanced/piholetweaks/pihole-extended-hosts/host-blocklist/hosts /var/www/html/lists/extended.txt
sudo service dnsmasq restart
