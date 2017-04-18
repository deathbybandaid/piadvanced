##Fail2Ban
{ if (whiptail --yesno "Do you want to install fail2ban?" 8 78) then
sudo apt-get install -y fail2ban
else
echo ""
fi }
