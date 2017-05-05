#!/bin/sh
## Samba Share
NAMEOFAPP="sambashare"
WHATITDOES="This is a Windows compatible file-sharing protocol"

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
SAMBASHARENAME=$(whiptail --inputbox "What do you want your share to be named?" 10 80 "" 3>&1 1>&2 2>&3)
sudo apt-get install -t stretch -y samba
sudo apt-get install -t stretch -y samba-common-bin
sudo sed -i "s/#   wins support = no/wins support = yes/" /etc/samba/smb.conf
sudo mkdir /etc/piadvanced/$SAMBASHARENAME
sudo echo "["$SAMBASHARENAME"]" | sudo tee --append /etc/samba/smb.conf
sudo echo " comment=Raspberry Pi Share" | sudo tee --append /etc/samba/smb.conf
sudo echo " path=/etc/piadvanced/"$SAMBASHARENAME"/" | sudo tee --append /etc/samba/smb.conf
sudo echo " browseable=Yes" | sudo tee --append /etc/samba/smb.conf
sudo echo " writeable=Yes" | sudo tee --append /etc/samba/smb.conf
sudo echo " only guest=no" | sudo tee --append /etc/samba/smb.conf
sudo echo " create mask=0777" | sudo tee --append /etc/samba/smb.conf
sudo echo " directory mask=0777" | sudo tee --append /etc/samba/smb.conf
sudo echo " public=no" | sudo tee --append /etc/samba/smb.conf
sudo echo "" | sudo tee --append /etc/samba/smb.conf
sudo smbpasswd -a $CURRENTUSER
sudo echo ""$NAMEOFAPP"firewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf


## End of install
fi }

## Unset Temporary Variables
unset NAMEOFAPP
unset CURRENTUSER
unset WHATITDOES

## Module Comments
