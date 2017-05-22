#!/bin/bash
# update the host blocklist
cd /home/vagrant/host-blocklist
sudo git pull

# update the hosts blocklist
./makeHosts

if [ ! -d /etc/pihole ]; then
    sudo ln -s ~/pihole /etc/pihole
fi

# dedupe the generated blocklist against the pihole gravity list
echo "" > hosts2
GRAVITY=`cat gravity.list`
HOSTS=`cat hosts`

for HOST in HOSTS; do
  if [[ "$GRAVITY" == *"$HOST"* ]]; then
       continue;
   fi
   echo "$HOST" >> hosts2
done

rm -f hosts
mv hosts2 hosts
sudo service dnsmasq restart
