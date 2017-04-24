#!/bin/sh
## pihole
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install pihole?" 8 78) then
echo "User Declined Pi-Hole"
else
git clone --depth 1 https://github.com/pi-hole/pi-hole.git /etc/piadvanced/installscripts/Pi-hole
cd /etc/piadvanced/installscripts/Pi-hole/automated\ install/
bash basic-install.sh
whiptail --msgbox " This is to change pihole password" 20 70 1
NEW_PASS=$(whiptail --inputbox "Please enter a password" 20 60 "" 3>&1 1>&2 2>&3)
pihole -a -p $NEW_PASS

## Wally3k Adlists
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install the Wally3k adlists.list?" 8 78) then
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Would you like to copy adlists.default to adlists.list instead?" 8 78) then
echo "User Declined Using adlists.list"
else
sudo cp /etc/pihole/adlists.default /etc/pihole/adlists.list
fi }
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/wally3k-adlists.list/master/adlists.list -P /etc/pihole/
fi }

## Dark Theme
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install Dark webui theme?" 8 78) then
echo "User Declined Dark Theme"
else
sudo wget https://raw.githubusercontent.com/lkd70/PiHole-Dark/master/install.sh -P /var/www/html/
cd /var/www/html
chmod +x install.sh
sudo bash install.sh
fi }

## Wall3k Block Page
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install the wally3k block page?" 8 78) then
echo "User Declined using Wally3k's Block Page"
else
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
fi }

## Bypass
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install deathbybandaid dnsmasq tweaks? See readme for more information." 8 78) then
echo "User Declined deathbybandaid dnsmasq tweaks"
else
# bypass
sudo wget https://raw.githubusercontent.com/deathbybandaid/pihole-bypass/master/04-bypass.conf -P /etc/dnsmasq.d/
# add interfaces
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeinterfaces/master/05-addint.conf -P /etc/dnsmasq.d/
# active directory
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeAD/master/06-activedirectory.conf -P /etc/dnsmasq.d/
# Static leases.
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholestaticip/master/08-staticip.conf -P /etc/dnsmasq.d/
#Do not lease IP to a certain device.
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeblockdhcp/master/09-noip4you.conf -P /etc/dnsmasq.d/
# custom redirects
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholecustomredirect/master/07-customredirect.conf -P /etc/dnsmasq.d/
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholecustomredirect/master/customRedirect.list -P /etc/piadvanced/installscripts/
fi }


## pihole -up 30 minutes
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do youw want to run pihole -up every 30 minutes?" 8 78) then
echo "User Declined 30 minute autoupdates"
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeautoupdate/master/piholeautoupdate.sh -P /etc/piadvanced/installscripts/
(crontab -l ; echo "0,30 * * * * bash /etc/piadvanced/installscripts/piholeautoupdate.sh") | crontab -
fi }

## Weekly old list removal
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want a script to keep cached lists from becoming stale?" 8 78) then
echo "User Declined Stale List Fix"
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholefreshlists/master/piholefreshlists.sh -P /etc/piadvanced/installscripts/
(crontab -l ; echo "0 5 * * 1 /etc/piholescripts/piholefreshlists.sh") | crontab -
fi }

## Gravity 6 hours
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want a script to update gravity every 6 hours?" 8 78) then
echo "User Declined Updating gravity every 6 hours"
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholegravity/master/piholegravity.sh -P /etc/piadvanced/installscripts/
(crontab -l ; echo "0 */6 * * * sudo bash /etc/piholescripts/piholegravity.sh") | crontab -
fi }

## Parser
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want a program to parse additional lists? By default this uses lists used by ublock. To change the lists, edit lists.lst in /etc/piadvanced/installscripts/ublockpihole/" 8 78) then
echo "User Declined the UBlock Parser"
else
sudo git clone https://github.com/deathbybandaid/ublockpihole.git /etc/piadvanced/installscripts/ublockpihole/
(crontab -l ; echo "0 1 * * * /etc/piholescripts/ublockpihole/ublockpihole.sh") | crontab -
sudo echo "#http://localhost/admin/ublock.txt" | sudo tee --append /etc/pihole/adlists.list
fi }

## Experimental youtube ad blocking
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use an script to add additional youtube adblocking?" 8 78) then
echo "User Declined the youtube ad blocker"
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/youtubeadblock/master/youtubeadblock.sh -P /etc/piadvanced/installscripts/
(crontab -l ; echo "0 2 * * * /etc/piadvanced/installscripts/youtubeadblock/youtube-ads.sh") | crontab -
sudo echo "#http://localhost/admin/youtube.txt" | sudo tee --append /etc/pihole/adlists.list
fi }

## Adguard
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use a script to add adguard blocking?" 8 78) then
echo "User Declined adguard parser"
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/pihole-adguard/master/adguard.sh -P /etc/piadvanced/installscripts/
(crontab -l ; echo "0 3 * * * sudo bash /etc/piadvanced/installscripts/adguard.sh") | crontab -
sudo echo "#http://localhost/admin/adguard.txt" | sudo tee --append /etc/pihole/adlists.list
fi }

## PHP list parser
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to use the PHP Parser?" 8 78) then
echo "User Declined the PHP Parser"
else
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholephpadblocking/master/parser.php -P /var/www/html/admin/
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


fi }
