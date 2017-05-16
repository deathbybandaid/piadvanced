#!/bin/sh
## php parser
NAMEOFAPP="piholephpparser"
WHATITDOES="This is a PHP block list parser/formatter."

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 8 78) 
then
echo "$CURRENTUSER Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=no" | sudo tee --append /etc/piadvanced/install/variables.conf
else
echo "$CURRENTUSER Accepted $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=yes" | sudo tee --append /etc/piadvanced/install/variables.conf

## Below here is the magic.
sudo cp /etc/piadvanced/piholetweaks/parser.php /var/www/html/lists/
sudo echo "# PHP Parser" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=antipopads" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=adware_filters" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=easyprivacy_easylist" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=adguard_dns" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=fanboy_ultimate" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=blockzilla" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=openpish" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=malwareurls" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=adguard_mobile" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=easylist_de2" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=adguard_en" | sudo tee --append /etc/pihole/adlists.list
sudo echo "http://pi.hole/lists/parser.php?list=adguard_de" | sudo tee --append /etc/pihole/adlists.list

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
