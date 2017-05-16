#!/bin/bash
sudo mkdir /var/www/html/lists
sudo rm /var/www/html/lists/ublock.txt
for source in `cat /etc/piadvanced/piholetweaks/ublockpihole/lists.lst`; do
    echo $source;
    sudo curl --silent $source >> /etc/piadvanced/piholetweaks/ublockpihole/ads.txt
    echo -e "\t`wc -l /etc/piadvanced/piholetweaks/ublockpihole/ads.txt | cut -d " " -f 1` lines downloaded"
done

echo -e "\nFiltering non-url content..."
sudo perl /etc/piadvanced/piholetweaks/ublockpihole/easylist.pl /etc/piadvanced/piholetweaks/ublockpihole/ads.txt > /etc/piadvanced/piholetweaks/ublockpihole/ads_parsed.txt
sudo rm /etc/piadvanced/piholetweaks/ublockpihole/ads.txt
echo -e "\t`wc -l /etc/piadvanced/piholetweaks/ublockpihole/ads_parsed.txt | cut -d " " -f 1` lines after parsing"

echo -e "\nRemoving duplicates..."
sort -u /etc/piadvanced/piholetweaks/ublockpihole/ads_parsed.txt > /etc/piadvanced/piholetweaks/ublockpihole/ads_unique.txt
sudo rm /etc/piadvanced/piholetweaks/ublockpihole/ads_parsed.txt
echo -e "\t`wc -l /etc/piadvanced/piholetweaks/ublockpihole/ads_unique.txt | cut -d " " -f 1` lines after deduping"

sudo cat /etc/piadvanced/piholetweaks/ublockpihole/ads_unique.txt >> /var/www/html/lists/ublock.txt
sudo rm /etc/piadvanced/piholetweaks/ublockpihole/ads_unique.txt
