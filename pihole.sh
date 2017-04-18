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
{ if (whiptail --yesno "Would you like to copy adlists.default to adlists.list instead?" 8 78) then
sudo cp /etc/pihole/adlists.default /etc/pihole/adlists.list
else
echo ""
fi }
fi }


## Dark Theme
{ if (whiptail --yesno "Do you want to install Dark webui theme?" 8 78) then
sudo wget https://raw.githubusercontent.com/lkd70/PiHole-Dark/master/install.sh -P /var/www/html/
cd /var/www/html
chmod +x install.sh
sudo bash install.sh
else
echo ""
fi }

## Wall3k Block Page
{ if (whiptail --yesno "Do you want to install the wally3k block page?" 8 78) then
[ -f "/var/phbp.ini" ] && sudo mv /var/phbp.ini /var/phbp.ini.BAK
html=$(grep server.document-root /etc/lighttpd/lighttpd.conf | awk -F\" '{print $2}')
sudo wget -q https://raw.githubusercontent.com/WaLLy3K/Pi-hole-Block-Page/master/index.php -O "$html/index.php"
sudo wget -q https://raw.githubusercontent.com/WaLLy3K/Pi-hole-Block-Page/master/phbp.ini -O "/var/phbp.ini"
sudo chmod 755 "$html/index.php"
[ -f "/var/phbp.php" ] && sudo mv /var/phbp.php /var/phbp.old.BAK
[ ! -d "/etc/lighttpd/conf-enabled" ] && sudo mkdir -m 755 /etc/lighttpd/conf-enabled
[ ! -f "/etc/lighttpd/conf-enabled/phbp.conf" ] && echo -e '# Pi-hole "server.error-handler-404" override\nurl.rewrite-once = ( "pihole/index.php" => "/index.php" )' | sudo tee /etc/lighttpd/conf-enabled/phbp.conf
echo "Done! Please edit '/var/phbp.ini' to customise your install"
sudo service lighttpd force-reload
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
(crontab -l ; echo "0,30 * * * * bash /etc/piadvanced/installscripts/piholeautoupdate.sh") | crontab -
else
echo ""
fi }

## Weekly old list removal
{ if (whiptail --yesno "Do you want a script to keep cached lists from becoming stale?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholefreshlists/master/piholefreshlists.sh -P /etc/piadvanced/installscripts/
(crontab -l ; echo "0 5 * * 1 /etc/piholescripts/piholefreshlists.sh") | crontab -
else
echo ""
fi }

## Gravity 6 hours
{ if (whiptail --yesno "Do you want a script to update gravity every 6 hours?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholegravity/master/piholegravity.sh -P /etc/piadvanced/installscripts/
(crontab -l ; echo "0 */6 * * * sudo bash /etc/piholescripts/piholegravity.sh") | crontab -
else
echo ""
fi }

## Parser
{ if (whiptail --yesno "Do you want a program to parse additional lists? By default this uses lists used by ublock. To change the lists, edit lists.lst in /etc/piadvanced/installscripts/ublockpihole/" 8 78) then
sudo git clone https://github.com/deathbybandaid/ublockpihole.git /etc/piadvanced/installscripts/ublockpihole/
(crontab -l ; echo "0 1 * * * /etc/piholescripts/ublockpihole/ublockpihole.sh") | crontab -
sudo echo "http://localhost/admin/ublock.txt" | sudo tee --append /etc/pihole/adlists.list
else
echo ""
fi }

## Experimental youtube ad blocking
{ if (whiptail --yesno "Do you want to use an script to add additional youtube adblocking?" 8 78) then
sudo wget https://raw.githubusercontent.com/deathbybandaid/youtubeadblock/master/youtubeadblock.sh -P /etc/piadvanced/installscripts/
(crontab -l ; echo "0 2 * * * /etc/piadvanced/installscripts/youtubeadblock/youtube-ads.sh") | crontab -
sudo echo "http://localhost/admin/youtube.txt" | sudo tee --append /etc/pihole/adlists.list
else
echo ""
fi }
