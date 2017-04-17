## Timezone
{
  dpkg-reconfigure tzdata
}
## SSH
## I might add the option to use a key versus password for login.
{ whiptail --yesno "Would you like the SSH server enabled or disabled?" 20 60 2 \
--yes-button Enable --no-button Disable
RET=$?
if [ $RET -eq 0 ]; then
update-rc.d ssh enable &&
invoke-rc.d ssh start &&
whiptail --msgbox "SSH server enabled" 20 60 1
elif [ $RET -eq 1 ]; then
update-rc.d ssh disable &&
whiptail --msgbox "SSH server disabled" 20 60 1
else
return $RET
fi }
## This sets the memory split down to 16
{ if (whiptail --yesno "Do you plan on running headless? This will set the memory split to 16." 8 78) then
sudo sed -i "s/\($gpu_mem *= *\).*/\1$116/"  /boot/config.txt
else
echo ""
fi }
