## 
{ if (whiptail --yesno "Do you wnat to install the random number fix?" 8 78) then
sudo apt-get install -y rng-tools
sudo echo 'HRNGDEVICE=/dev/urandom' | sudo tee --append /etc/default/rng-tools
else
echo ""
fi }
