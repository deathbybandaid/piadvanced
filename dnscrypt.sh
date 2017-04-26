#!/bin/sh
## DNSCRYPT
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install DNSCrypt?" 8 78) then
echo "User Declined DNSCrypt"
else
sudo apt-get update
sudo apt-get -y install build-essential tcpdump dnsutils libsodium-dev 
sudo apt-get -y install locate bash-completion libsystemd-dev pkg-config
mkdir -p dnsproxy
cd dnsproxy
wget https://download.dnscrypt.org/dnscrypt-proxy/LATEST.tar.bz2
tar -xf LATEST.tar.bz2
rm LATEST.tar.bz2
pattern="dnscrypt-proxy-"
for _dir in *"${pattern}"*; do     [ -d "${_dir}" ] && dir="${_dir}" && break; done
cd $dir
sudo ldconfig
./configure --with-systemd
make
sudo make install
sudo useradd -r -d /var/dnscrypt -m -s /usr/sbin/nologin dnscrypt
echo Done
echo Adding Resolver Processes To rc.local
sudo sed -i '/exit 0/d' /etc/rc.local
sudo sed -i '/dnscrypt-proxy/d' /etc/rc.local
sudo sed -i '$i /usr/local/sbin/dnscrypt-proxy --resolver-name=dnscrypt.eu-dk --user=dnscrypt -a 127.0.0.2:5454 --edns-payload-size=4096 --logfile=/var/log/dnscrypt-proxy.1.log &> /dev/null &' /etc/rc.local
sudo sed -i '$i /usr/local/sbin/dnscrypt-proxy --resolver-name=cs-ch --user=dnscrypt -a 127.0.0.3:5656 --edns-payload-size=4096 --logfile=/var/log/dnscrypt-proxy.2.log &> /dev/null &' /etc/rc.local
sudo sed -i '$i /usr/local/sbin/dnscrypt-proxy --resolver-name=d0wn-is-ns1 --user=dnscrypt -a 127.0.0.4:5757 --edns-payload-size=4096 --logfile=/var/log/dnscrypt-proxy.3.log &> /dev/null &' /etc/rc.local
sudo sed -i '$i exit 0' /etc/rc.local
echo Starting Resolvers Manually (Will load via rc.local after reboot)
sudo kill $(ps aux | grep 'dnscrypt-proxy' | awk '{print $2}')
sudo /usr/local/sbin/dnscrypt-proxy --resolver-name=dnscrypt.eu-dk --user=dnscrypt -a 127.0.0.2:5454 --edns-payload-size=4096 --logfile=/var/log/dnscrypt-proxy.1.log &> /dev/null &
sudo /usr/local/sbin/dnscrypt-proxy --resolver-name=cs-ch --user=dnscrypt -a 127.0.0.3:5656 --edns-payload-size=4096 --logfile=/var/log/dnscrypt-proxy.2.log &> /dev/null &
sudo /usr/local/sbin/dnscrypt-proxy --resolver-name=d0wn-is-ns1 --user=dnscrypt -a 127.0.0.4:5757 --edns-payload-size=4096 --logfile=/var/log/dnscrypt-proxy.3.log &> /dev/null &
echo Adding Entries To Host File
sudo sed -i '/dnscrypt.eu/d' /etc/hosts
sudo sed -i '/cs-ch/d' /etc/hosts
sudo sed -i '/d0wn-is-ns1/d' /etc/hosts
sudo sed -i '$i 127.0.0.2       dnscrypt.eu-dk' /etc/hosts
sudo sed -i '$i 127.0.0.3       cs-ch' /etc/hosts
sudo sed -i '$i 127.0.0.4       d0wn-is-ns1' /etc/hosts
echo Adding Entries to DNSMasq
sudo /etc/init.d/dnsmasq stop
sudo sed -i '/server=/d' /etc/dnsmasq.d/01-pihole.conf
sudo sed -i '$i server=127.0.0.2#5454' /etc/dnsmasq.d/01-pihole.conf
sudo sed -i '$i server=127.0.0.3#5656' /etc/dnsmasq.d/01-pihole.conf
sudo sed -i '$i server=127.0.0.4#5757' /etc/dnsmasq.d/01-pihole.conf
sudo /etc/init.d/dnsmasq start
ps aux | grep 'dnscrypt-proxy'
echo Done
sudo echo "dnscryptfirewall=yes" | sudo tee --append /etc/piadvanced/install/firewall.conf
fi }
