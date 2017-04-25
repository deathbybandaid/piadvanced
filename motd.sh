#!/bin/sh
## Message of the day
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to Change your message of the day to a much cooler one?" 8 78) then
echo "User Declined setting a cooler motd message"
else
whiptail --msgbox "This is the message you receive at login" 20 70 1
#sudo uname -snrvm > /var/run/motd.dynamic
sudo systemctl disable motd
sudo mkdir /etc/update-motd.d
sudo rm -f /etc/motd
sudo wget https://raw.githubusercontent.com/deathbybandaid/pimotd/master/10logo -P /etc/update-motd.d/
sudo chmod a+x /etc/update-motd.d/*
sudo sed -i "s/motd.dynamic/motd.new/" /etc/pam.d/sshd
fi }
