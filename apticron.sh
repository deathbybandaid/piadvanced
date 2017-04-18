#!/bin/sh
## Apticron
{ if (whiptail --yesno "Do you want to install apticron to recieve updates when you have pending updates?" 8 78) then
APTICRON_EMAIL=$(whiptail --inputbox "What email address do you want to use?" 20 60 "user@domain.net" 3>&1 1>&2 2>&3)
sudo apt-get install apticron
sudo sed -i "s/EMAIL="root"/EMAIL="$APTICRON_EMAIL"/" /etc/apticron/apticron.conf
else
echo ""
fi }
