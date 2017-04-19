#!/bin/sh
## Message of the day
{ if (whiptail --yesno "Do you want to Change your message of the day to a much cooler one?" 8 78) then
whiptail --msgbox "This is the message you receive at login" 20 70 1
sudo systemctl disable motd
mkdir /etc/update-motd.d
rm -f /etc/motd
sudo wget https://raw.githubusercontent.com/deathbybandaid/pimotd/master/10logo -P /etc/update-motd.d/
else
echo ""
fi }
