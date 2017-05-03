#!/bin/sh
## Simple test if Whiptail is installed. 

{ if
which whiptail >/dev/null;
then
:
else
sudo apt-get install -y whiptail
fi }
