#!/bin/bash
sudo rm /var/www/html/admin/ublock.txt
for source in `cat lists.lst`; do
    echo $source;
    sudo curl --silent $source >> ads.txt
    echo -e "\t`wc -l ads.txt | cut -d " " -f 1` lines downloaded"
done

echo -e "\nFiltering non-url content..."
sudo perl easylist.pl ads.txt > ads_parsed.txt
sudo rm ads.txt
echo -e "\t`wc -l ads_parsed.txt | cut -d " " -f 1` lines after parsing"

echo -e "\nRemoving duplicates..."
sort -u ads_parsed.txt > ads_unique.txt
sudo rm ads_parsed.txt
echo -e "\t`wc -l ads_unique.txt | cut -d " " -f 1` lines after deduping"

sudo cat ads_unique.txt >> /var/www/html/admin/ublock.txt
sudo rm ads_unique.txt
