#!/bin/sh
sleep 10
sudo python /etc/piadvanced/netmon/netmon.py -d 100M -u 5M -c /etc/piadvanced/netmon/auth.json -m "I'm paying for 100 Mbps/6 Mbps and I'm only getting %s/%s right now!"
