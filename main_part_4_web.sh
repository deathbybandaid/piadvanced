#!/bin/sh
whiptail --msgbox "During the install, multiple webservers could be installed. Let's try to adjust the configs to not interfere with eachother" 20 70 1
whiptail --msgbox "If these aren't set correctly, you will have to manually adjust them, because they may not start properly." 20 70 1

{ if (whiptail --yesno "Do you Want to install Lighttpd?" 8 78) then
sudo bash lighttpd.sh
else
echo ""
fi }

{ if (whiptail --yesno "Do you Want to install Nginx" 8 78) then
sudo bash nginx.sh
else
echo ""
fi }

{ if (whiptail --yesno "Do you Want to install Apache" 8 78) then
sudo bash apache.sh
else
echo ""
fi }
