#!/bin/bash

## Youtube adblocking
rm /var/www/html/admin/youtube.txt
rm /etc/piadvanced/installscripts/youtubeadblock/youtube-domains.txt
rm /etc/piadvanced/installscripts/youtubeadblock/youtube-filtered.txt
rm /etc/piadvanced/installscripts/youtubeadblock/youtube-ads.txt
python /etc/piadvanced/installscripts/youtubeadblock/API_example.py > /etc/piadvanced/installscripts/youtubeadblock/youtube-domains.txt
grep "^r" /etc/piadvanced/installscripts/youtubeadblock/youtube-domains.txt > /etc/piadvanced/installscripts/youtubeadblock/youtube-filtered.txt
sed 's/\s.*$//' /etc/piadvanced/installscripts/youtubeadblock/youtube-filtered.txt > /etc/piadvanced/installscripts/youtubeadblock/youtube-ads.txt
cp /etc/piadvanced/installscripts/youtubeadblock/youtube-ads.txt /var/www/html/admin/youtube.txt
#greps the log for youtube ads and appends to /var/www/html/admin/youtube.txt
grep r*.googlevideo.com /var/log/pihole.log | awk '{print $6}'| grep -v '^googlevideo.com\|redirector' | sort -nr | uniq >> /var/www/html/admin/youtube.txt
#removes duplicate lines from /var/www/html/youtube.txt
perl -i -ne 'print if ! $x{$_}++' /var/www/html/admin/youtube.txt
#updates pihole blacklist/whitelist
#pihole -g
