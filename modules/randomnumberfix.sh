#!/bin/sh
## Random Number fix

## Variables
source /etc/piadvanced/install/firewall.conf
source /etc/piadvanced/install/variables.conf
source /etc/piadvanced/install/userchange.conf

{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you wnat to install the random number fix?" 8 78) then
echo "User Declined RNG"
else
sudo apt-get install -y rng-tools
sudo cp /etc/default/rng-tools /etc/piadvanced/backups/
sudo echo 'HRNGDEVICE=/dev/urandom' | sudo tee --append /etc/default/rng-tools
fi }
