#!/bin/sh
#
# sudo nano /etc/iptables.firewall.rules
#
# sudo iptables-restore < /etc/iptables.firewall.rules
#
# sudo nano /etc/network/if-pre-up.d/firewall
#
# #!/bin/sh
# /sbin/iptables-restore < /etc/iptables.firewall.rules
#
# sudo chmod +x /etc/network/if-pre-up.d/firewall
#
# sudo cp /etc/network/if-pre-up.d/firewall /etc/piadvanced/installscripts/firewall.sh
# 
# (crontab -l ; echo "0 */6 * * * sudo bash /etc/piadvanced/installscripts/firewall.sh") | crontab -

#sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
