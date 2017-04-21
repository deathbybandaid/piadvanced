#!/bin/sh
source /etc/piadvanced/install/variables.conf
## IPTables Firewall
## This will create a script to make sure the firewall is intact at boot , and every 6 hours.
{ if (whiptail --yesno "Do you want Activate a firwall created based on this install?" 8 78) then
sudo echo "#!/bin/sh" | sudo tee --append /etc/network/if-pre-up.d/firewall
sudo echo "/sbin/iptables-restore < /etc/iptables.firewall.rules" | sudo tee --append /etc/network/if-pre-up.d/firewall
sudo chmod +x /etc/network/if-pre-up.d/firewall
sudo cp /etc/network/if-pre-up.d/firewall /etc/piadvanced/installscripts/firewall.sh 
(crontab -l ; echo "0 */6 * * * sudo bash /etc/piadvanced/installscripts/firewall.sh") | crontab -
else
echo ""
fi }

sudo echo "#  Drop all other inbound - default deny unless explicitly allowed policy" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -j DROP" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A FORWARD -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "COMMIT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "*nat" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":PREROUTING ACCEPT [264:40146]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":INPUT ACCEPT [48:3296]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":OUTPUT ACCEPT [192:14170]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo ":POSTROUTING ACCEPT [192:14170]" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "## Openvpn (If Selected)" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "$OPENVPN_NAT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "COMMIT" | sudo tee --append /etc/iptables.firewall.rules
