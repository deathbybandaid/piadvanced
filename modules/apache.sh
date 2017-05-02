#!/bin/sh
## Apache

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you plan on running Apache" 8 78) then
echo "User Declined Apache"
else
{
source /etc/piadvanced/install/variables.conf
whiptail --msgbox "What ports do you want Apache to use?" 20 70 1
whiptail --msgbox "I suggest changing Apache Ports to something like 85 and 445" 20 70 1
NEW_APACHE80=$(whiptail --inputbox "Change the default port 80 for Apache" 20 60 "85" 3>&1 1>&2 2>&3)
NEW_APACHE443=$(whiptail --inputbox "Change the default port 443 for Apache" 20 60 "445" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo apt-get install -y apache2
sudo cp -r /etc/apache2/ /etc/piadvanced/backups/apache2/
sudo echo "NEW_APACHE80=$NEW_APACHE80" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo echo "NEW_APACHE443=$NEW_APACHE443" | sudo tee --append /etc/piadvanced/install/variables.conf
sudo sed -i "s/80/$NEW_APACHE80/" /etc/apache2/ports.conf
sudo sed -i "s/80/$NEW_APACHE80/" /etc/apache2/sites-enabled/000-default.conf
sudo sed -i "s/443/$NEW_APACHE443/" /etc/apache2/ports.conf
sudo sed -i "s/443/$NEW_APACHE443/" /etc/apache2/sites-enabled/000-default.conf
fi  }
fi }
