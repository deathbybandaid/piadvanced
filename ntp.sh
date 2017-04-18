## NTP
{ if (whiptail --yesno "Do you want to set ntp servers? serverlist is available at http://support.ntp.org/bin/view/Servers/NTPPoolServers" 8 78) then
NEW_NTP=$(whiptail --inputbox "Set server here" 20 60 "debian.pool.ntp.org" 3>&1 1>&2 2>&3)
sudo sed -i "s/pool 0.debian.pool.ntp.org iburst/pool 0.$NEW_NTP iburst/" /etc/ntp.conf
sudo sed -i "s/pool 1.debian.pool.ntp.org iburst/pool 1.$NEW_NTP iburst/" /etc/ntp.conf
sudo sed -i "s/pool 2.debian.pool.ntp.org iburst/pool 2.$NEW_NTP iburst/" /etc/ntp.conf
sudo sed -i "s/pool 3.debian.pool.ntp.org iburst/pool 3.$NEW_NTP iburst/" /etc/ntp.conf
sudo service ntp stop
sudo ntpd -gq
sudo service ntp start
else
echo ""
fi }
