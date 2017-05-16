#!/bin/bash
sudo rm /etc/piadvanced/piholetweaks/filterlistscom/lists.lst
sudo rm /etc/piadvanced/piholetweaks/filterlistscom/breaktheinternet.list
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/breaktheinternet.list -P /etc/piadvanced/piholetweaks/filterlistscom/
sudo mv /etc/piadvanced/piholetweaks/filterlistscom/breaktheinternet.list /etc/piadvanced/piholetweaks/filterlistscom/lists.lst
sudo mkdir /var/www/html/lists
sudo rm /var/www/html/lists/filterlistscom.txt
for source in `cat /etc/piadvanced/piholetweaks/filterlistscom/lists.lst`; do
    echo $source;
    sudo curl --silent $source >> /etc/piadvanced/piholetweaks/filterlistscom/ads.txt
    echo -e "\t`wc -l ads.txt | cut -d " " -f 1` lines downloaded"
done

echo -e "\nFiltering non-url content..."
sudo perl /etc/piadvanced/piholetweaks/filterlistscom/easylist.pl /etc/piadvanced/piholetweaks/filterlistscom/ads.txt > /etc/piadvanced/piholetweaks/filterlistscom/ads_parsed.txt
sudo rm /etc/piadvanced/piholetweaks/filterlistscom/ads.txt
echo -e "\t`wc -l /etc/piadvanced/piholetweaks/filterlistscom/ads_parsed.txt | cut -d " " -f 1` lines after parsing"

echo -e "\nRemoving duplicates..."
sort -u /etc/piadvanced/piholetweaks/filterlistscom/ads_parsed.txt > /etc/piadvanced/piholetweaks/filterlistscom/ads_unique.txt
sudo rm /etc/piadvanced/piholetweaks/filterlistscom/ads_parsed.txt
echo -e "\t`wc -l /etc/piadvanced/piholetweaks/filterlistscom/ads_unique.txt | cut -d " " -f 1` lines after deduping"

sudo cat /etc/piadvanced/piholetweaks/filterlistscom/ads_unique.txt >> /var/www/html/lists/filterlistscom.txt
sudo rm /etc/piadvanced/piholetweaks/filterlistscom/ads_unique.txt
