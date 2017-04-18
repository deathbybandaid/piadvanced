#!/bin/sh
################################################################
##          This is The Deathbybandaid Pihole Install         ##
################################################################
##    This Must be run as root, or it fails is some places    ##
################################################################
#{ if (whiptail --yesno "Are you running as root?" 8 78) then
#echo ""
#else
#exit
#fi }
## This is where we will download installations.
sudo mkdir /etc/piadvanced/installscripts
## This is where we will put backups of important files. I maywrite a reversion script later.
sudo mkdir /etc/piadvanced/backups
## This document will contain all of our setup variables. Date/Time Stamped.
mkdir /etc/piadvanced/install
timestamp=`date --rfc-3339=seconds`
sudo echo "## Variables for Install" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "## $timestamp" | sudo tee --append /etc/piadvanced/install/variables.conf
## Here we Go!!
whiptail --msgbox "This is The Deathbybandaid Pihole Install" 20 70 1
