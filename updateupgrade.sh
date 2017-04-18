#!/bin/sh
## Updates
{ whiptail --msgbox "I'm going to run updates." 20 70 1 
sudo apt-get install -y
sudo apt-get update --fix-missing
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt-get clean
 }
