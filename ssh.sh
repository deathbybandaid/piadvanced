#!/bin/sh
## SSH
## I might add the option to use a key versus password for login.
{ whiptail --yesno "Would you like the SSH server enabled or disabled?" 20 60 2 \
--yes-button Enable --no-button Disable
RET=$?
if [ $RET -eq 0 ]; then
update-rc.d ssh enable &&
invoke-rc.d ssh start &&
whiptail --msgbox "SSH server enabled" 20 60 1
sudo echo "# SSH" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
elif [ $RET -eq 1 ]; then
update-rc.d ssh disable &&
whiptail --msgbox "SSH server disabled" 20 60 1
else
return $RET
fi }
