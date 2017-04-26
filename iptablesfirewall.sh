#!/bin/sh
## Message
whiptail --msgbox "Any network access will be blocked unless there is a rule to allow it." 20 70 1

## Variables
source /etc/piadvanced/install/variables.conf

## Remove old Firewall if there is one
sudo rm -r /etc/iptables.firewall.rules

## Filter Start
sudo echo "*filter" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

## Inbound Connections
sudo echo "#  Accept all established inbound connections" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

## Outbound Connections
sudo echo "#  Allow all outbound traffic - you can modify this to only allow certain traffic" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A OUTPUT -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

## HTTP HTTPS
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to allow traffic on Ports 80 and 443? These ports are typically web traffic" 8 78) then
echo "User Declined Firewall Ports 80 and 443"
else
sudo echo "#  Allow HTTP and HTTPS connections from anywhere (the normal ports for websites and SSL)." | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 80 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 443 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }

## SMTP
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to allow traffic on Ports 25, 465, and 587? These ports are for SMTP" 8 78) then
echo "User Declined Firewall Ports 25, 465, and 587"
else
sudo echo "# Allows SMTP access" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 25 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 465 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 587 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }

## POP POPS
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to allow traffic on Ports 110 and 995? These ports are for POP" 8 78) then
echo "User Declined Firewall Ports 110 and 995"
else
sudo echo "# Allows pop and pops connections" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 110 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 995 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }

## IMAP IMAPS
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to allow traffic on Ports 143 and 993? These ports are for IMAP" 8 78) then
echo "User Declined Firewall Ports 143 and 993"
else
sudo echo "# Allows imap and imaps connections" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 143 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --dport 993 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }

## Ping
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to allow Ping requests? These ports are for IMAP" 8 78) then
echo "User Declined Firewall Ping"
else
sudo echo "#  Allow ping" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p icmp --icmp-type echo-request -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }

## DHCP
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to allow traffic on Ports 67 and 68? These ports are for DHCP" 8 78) then
echo "User Declined Firewall Ports 67 and 68"
else
sudo echo "# DHCP" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --dport 67 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --dport 68 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }

## DNS
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to allow traffic on Port 53? This port are for DNS" 8 78) then
echo "User Declined Firewall Ports 53"
else
sudo echo "# DNS" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p tcp --destination-port 53 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -p udp --destination-port 53 -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
fi }

## Log Denied access
sudo echo "#  Log iptables denied calls" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -m limit --limit 5/min -j LOG --log-level 7" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules






sudo echo "#  Drop all other inbound - default deny unless explicitly allowed policy" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A INPUT -j DROP" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "-A FORWARD -j ACCEPT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

## End of *Filter
sudo echo "COMMIT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

## Begin Nat
sudo echo "*nat" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "## Openvpn (If Selected)" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "$OPENVPN_NAT" | sudo tee --append /etc/iptables.firewall.rules
sudo echo "" | sudo tee --append /etc/iptables.firewall.rules

sudo echo "COMMIT" | sudo tee --append /etc/iptables.firewall.rules


## This will create a script to make sure the firewall is intact at boot , and every 6 hours.
{ if (whiptail --yesno "Do you want Activate this firewall with scripts?" 8 78) then
sudo echo "#!/bin/sh" | sudo tee --append /etc/network/if-pre-up.d/firewall
sudo echo "/sbin/iptables-restore < /etc/iptables.firewall.rules" | sudo tee --append /etc/network/if-pre-up.d/firewall
sudo chmod +x /etc/network/if-pre-up.d/firewall
sudo cp /etc/network/if-pre-up.d/firewall /etc/piadvanced/installscripts/firewall.sh 
(crontab -l ; echo "0 */6 * * * sudo bash /etc/piadvanced/installscripts/firewall.sh") | crontab -
else
echo ""
fi }
