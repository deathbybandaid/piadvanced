## pihole
## 
{ if (whiptail --yesno "Do you want to install pihole?" 8 78) then
git clone --depth 1 https://github.com/pi-hole/pi-hole.git /etc/piadvanced/installscripts/Pi-hole
cd /etc/piadvanced/installscripts/Pi-hole/automated\ install/
bash basic-install.sh
else
echo ""
fi }




{ whiptail --msgbox " This is to change pihole password" 20 70 1
  NEW_PASS=$(whiptail --inputbox "Please enter a password" 20 60 "" 3>&1 1>&2 2>&3)
  if [ $? -eq 0 ]; then pihole -a -p $NEW_PASS
fi }


{ whiptail --msgbox "Installing some dnsmasq tweaks. See Readme" 20 70 1
sudo wget https://raw.githubusercontent.com/deathbybandaid/pihole-bypass/master/04-bypass.conf -P /etc/dnsmasq.d/
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeinterfaces/master/05-addint.conf -P /etc/dnsmasq.d/
sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeAD/master/06-activedirectory.conf -P /etc/dnsmasq.d/
 }
