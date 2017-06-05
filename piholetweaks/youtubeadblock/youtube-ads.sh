#!/bin/bash
## Youtube adblocking

## Directory Check
if 
[ -d "/var/www/html/lists/" ] 
then
echo "" 
else
sudo mkdir /var/www/html/lists/
fi

## Directory Location
YTOLDLIST=/var/www/html/lists/youtube.txt
YTDOMAINS=/etc/piholeparser/youtubewildcards/youtube-domains.txt
YTFILTERED=/etc/piholeparser/youtubewildcards/youtube-filtered.txt
YTADS=/etc/piholeparser/youtubewildcards/youtube-ads.txt
APIPY=/etc/piholeparser/youtubewildcards/API.py

## Cleanup
if 
ls $YTOLDLIST &> /dev/null; 
then
sudo rm $YTOLDLIST
else
:
fi

if 
ls $YTDOMAINS &> /dev/null; 
then
sudo rm $YTDOMAINS
else
:
fi

if 
ls $YTFILTERED &> /dev/null; 
then
sudo rm $YTFILTERED
else
:
fi

if 
ls $YTADS &> /dev/null; 
then
$YTADS
else
:
fi

sudo python $APIPY > $YTDOMAINS
sudo grep "^r" $YTDOMAINS > $YTFILTERED
sudo sed 's/\s.*$//' $YTFILTERED > $YTADS
sudo cp $YTADS $YTOLDLIST

#greps the log for youtube ads and appends to $YTOLDLIST
sudo grep r*.googlevideo.com /var/log/pihole.log | awk '{print $6}'| grep -v '^googlevideo.com\|redirector' | sort -nr | uniq >> $YTOLDLIST

#removes duplicate lines from $YTOLDLIST
sudo perl -i -ne 'print if ! $x{$_}++' $YTOLDLIST
