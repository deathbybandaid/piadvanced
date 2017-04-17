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
timestamp=`date --rfc-3339=seconds`
sudo mkdir /home/installs
sudo mkdir /home/backups
sudo echo "## Variables for Install" | sudo tee --append /home/dbbvariables
sudo echo "## $timestamp" | sudo tee --append /home/dbbvariables
