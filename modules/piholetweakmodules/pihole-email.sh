#!/bin/sh
## Pihole-Email
NAMEOFAPP="piholeemail" # This helps set the name of your app throught the module.
WHATITDOES="This will send you emails of your pihole stats."

## Current User
CURRENTUSER="$(whoami)"

## Dependencies Check
sudo bash /etc/piadvanced/dependencies/dep-whiptail.sh

## Variables (if in every file, an installer can be re-run independently)
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
sudo apt-get install -t stretch -y npm
sudo npm install emailjs --save
sudo npm install simple-git --save
sudo npm install http --save
sudo npm install fs --save
sudo npm cache clear --force && sudo npm install -g npm

sudo cp /etc/piadvanced/piholetweaks/piholeemail/bare-config.json /etc/piadvanced/piholetweaks/piholeemail/config.json
PIHOLESENDEMAIL=$(whiptail --inputbox "What Email are you sending from?" 20 60 "james@gmail.net" 3>&1 1>&2 2>&3)
PIHOLESENDPASS=$(whiptail --inputbox "What is the password for $PIHOLESENDEMAIL" 20 60 "" 3>&1 1>&2 2>&3)
PIHOLEEMAILHOSTNAME=$(whiptail --inputbox "What is the email hostname?" 20 60 "smtp.host.net" 3>&1 1>&2 2>&3)
PIHOLEEMAILTONAME=$(whiptail --inputbox "What is the name of the recipient?" 20 60 "John Doe" 3>&1 1>&2 2>&3)
PIHOLEEMAILTOADDRESS=$(whiptail --inputbox "What email address should the emails go to?" 20 60 "somebody@gmail.net" 3>&1 1>&2 2>&3)
PIHOLEEMAILSSL=$(whiptail --inputbox "SSL true or false (lowercase)?" 20 60 "true" 3>&1 1>&2 2>&3)
sudo sed -i "s/VALUE1/$PIHOLESENDEMAIL/" /etc/piadvanced/piholetweaks/piholeemail/config.json
sudo sed -i "s/VALUE2/$PIHOLESENDPASS/" /etc/piadvanced/piholetweaks/piholeemail/config.json
sudo sed -i "s/VALUE3/$PIHOLEEMAILHOSTNAME/" /etc/piadvanced/piholetweaks/piholeemail/config.json
sudo sed -i "s/VALUE4/$PIHOLEEMAILTONAME/" /etc/piadvanced/piholetweaks/piholeemail/config.json
sudo sed -i "s/VALUE5/$PIHOLEEMAILTOADDRESS/" /etc/piadvanced/piholetweaks/piholeemail/config.json
sudo sed -i "s/VALUE6/$PIHOLEEMAILSSL/" /etc/piadvanced/piholetweaks/piholeemail/config.json
(crontab -l ; echo "## Pihole Email") | crontab -
(crontab -l ; echo "59 23 * * * sudo nodejs /etc/piadvanced/piholetweaks/piholeemail/index.js") | crontab -
(crontab -l ; echo "") | crontab -


## Node figure out

## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
# https://github.com/MilesGG/Pi-Hole-Summary
