#!/bin/sh
## IPTables Firewall

## This will create a script to make sure the firewall is intact at boot , and every 6 hours.
sudo echo "#!/bin/sh" | sudo tee --append /etc/network/if-pre-up.d/firewall
sudo echo "/sbin/iptables-restore < /etc/iptables.firewall.rules" | sudo tee --append /etc/network/if-pre-up.d/firewall
sudo chmod +x /etc/network/if-pre-up.d/firewall
sudo cp /etc/network/if-pre-up.d/firewall /etc/piadvanced/installscripts/firewall.sh 
(crontab -l ; echo "0 */6 * * * sudo bash /etc/piadvanced/installscripts/firewall.sh") | crontab -

#sudo echo "" | sudo tee --append /etc/iptables.firewall.rules


