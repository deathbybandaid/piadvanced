#!/bin/sh
## pihole
{ if (whiptail --yesno "Do you want to install pihole?" 8 78) then
git clone --depth 1 https://github.com/pi-hole/pi-hole.git /etc/piadvanced/installscripts/Pi-hole
cd /etc/piadvanced/installscripts/Pi-hole/automated\ install/
bash basic-install.sh
else
echo ""
fi }
## pihole webui password
{ whiptail --msgbox " This is to change pihole password" 20 70 1
  NEW_PASS=$(whiptail --inputbox "Please enter a password" 20 60 "" 3>&1 1>&2 2>&3)
  if [ $? -eq 0 ]; then pihole -a -p $NEW_PASS
fi }

## Wally3k Adlists
{ if (whiptail --yesno "Do you want to install the Wally3k adlists.list?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/wally3k-adlists.list/master/adlists.list -P /etc/pihole/
else
echo ""
fi }

## Bypass
{ if (whiptail --yesno "Do you want to install a dnsmasq tweak to bypass pihole by mac address?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/pihole-bypass/master/04-bypass.conf -P /etc/dnsmasq.d/
else
echo ""
fi }

## Add Interfaces
{ if (whiptail --yesno "Do you want to install a dnsmasq tweak to add interfaces for pihole to listen on?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeinterfaces/master/05-addint.conf -P /etc/dnsmasq.d/
else
echo ""
fi }

## Active Directory
{ if (whiptail --yesno "Do you want to install a dnsmasq tweak to add your active directory dns servers to pihole?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeAD/master/06-activedirectory.conf -P /etc/dnsmasq.d/
else
echo ""
fi }

## pihole -up 30 minutes
{ if (whiptail --yesno "Do youw want to run pihole -up every 30 minutes?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeautoupdate/master/piholeautoupdate.sh -P /etc/piadvanced/installscripts/
# 0,30 * * * * bash /etc/piadvanced/installscripts/piholeautoupdate.sh
else
echo ""
fi }

## Weekly old list removal
{ if (whiptail --yesno "Do you want a script to keep cached lists from becoming stale?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholefreshlists/master/piholefreshlists.sh -P /etc/piadvanced/installscripts/
# 0 5 * * 1 /etc/piholescripts/piholefreshlists.sh
else
echo ""
fi }

## Gravity 6 hours
{ if (whiptail --yesno "Do you want a script to update gravity every 6 hours?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholegravity/master/piholegravity.sh -P /etc/piadvanced/installscripts/
# 0 */6 * * * sudo bash /etc/piholescripts/piholegravity.sh
else
echo ""
fi }

## 
{ if (whiptail --yesno "Do you want a program to parse additional lists? By default this uses lists used by ublock. To change the lists, edit lists.lst in /etc/piadvanced/installscripts/ublockpihole/" 8 78) then
git clone https://github.com/deathbybandaid/ublockpihole.git /etc/piadvanced/installscripts/ublockpihole/
# 0 1 * * * /etc/piholescripts/ublockpihole/ublockpihole.sh
# append adlists.list
else
echo ""
fi }
