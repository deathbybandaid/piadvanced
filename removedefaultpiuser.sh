{ if (whiptail --title "Deathbybandaid" --yesno "Are you running as root?" 8 78) then
echo "GooMbye"
else
exit
fi }
{ whiptail --msgbox "
Let's rename the user pi.
This will make the pi a great deal more secure.
I will ask you for a username and a password.
" 20 70 1
NEW_USERNAME=$(whiptail --inputbox "Please enter desired username, you will then be prompted to create a new password" 20 60 "" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then 
usermod -l $NEW_USERNAME -m -d /home/$NEW__USERNAME pi
groupmod -n $NEW_USERNAME pi
sudo passwd $NEW_USERNAME
fi }
