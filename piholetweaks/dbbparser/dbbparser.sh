#!/bin/bash
sudo rm /etc/piadvanced/piholetweaks/dbbparser/lists.lst
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/breaktheinternet.list -P /etc/piadvanced/piholetweaks/dbbparser/lists.lst
sudo mkdir /var/www/html/lists
sudo rm /var/www/html/lists/dbbparser.txt
for source in `cat /etc/piadvanced/piholetweaks/dbbparser/lists.lst`; do
    echo $source;
    sudo curl --silent $source >> /etc/piadvanced/piholetweaks/dbbparser/ads.txt
    echo -e "\t`wc -l ads.txt | cut -d " " -f 1` lines downloaded"
done

echo -e "\nFiltering non-url content..."
sudo perl /etc/piadvanced/piholetweaks/dbbparser/easylist.pl /etc/piadvanced/piholetweaks/dbbparser/ads.txt > /etc/piadvanced/piholetweaks/dbbparser/ads_parsed.txt
sudo rm /etc/piadvanced/piholetweaks/dbbparser/ads.txt
echo -e "\t`wc -l /etc/piadvanced/piholetweaks/dbbparser/ads_parsed.txt | cut -d " " -f 1` lines after parsing"

echo -e "\nRemoving duplicates..."
sort -u /etc/piadvanced/piholetweaks/dbbparser/ads_parsed.txt > /etc/piadvanced/piholetweaks/dbbparser/ads_unique.txt
sudo rm /etc/piadvanced/piholetweaks/dbbparser/ads_parsed.txt
echo -e "\t`wc -l /etc/piadvanced/piholetweaks/dbbparser/ads_unique.txt | cut -d " " -f 1` lines after deduping"

sudo cat /etc/piadvanced/piholetweaks/dbbparser/ads_unique.txt >> /var/www/html/lists/dbbparser.txt
sudo rm /etc/piadvanced/piholetweaks/dbbparser/ads_unique.txt
