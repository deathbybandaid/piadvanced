#!/bin/sh
## php parser

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if 
(whiptail --title "PHP Parser" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use the PHP Parser?" 10 80) 
then
echo "User Declined the PHP Parser"
else
sudo cp /etc/piadvanced/piholetweaks/parser.php /var/www/html/admin/
sudo echo "#http://localhost/admin/parser.php?list=antipopads" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adware_filters" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=easyprivacy_easylist" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adguard_dns" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=fanboy_ultimate" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=blockzilla" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=openpish" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=malwareurls" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adguard_mobile" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=easylist_de2" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adguard_en" | sudo tee --append /etc/pihole/adlists.list
sudo echo "#http://localhost/admin/parser.php?list=adguard_de" | sudo tee --append /etc/pihole/adlists.list
fi }
