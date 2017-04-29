#! / Bin / sh
## Updates
{whiptail --msgbox "I'm going to run updates." 20 70 1
sudo apt-get -y install
sudo apt-get -y update --fix-missing
sudo apt-get -y dist-upgrade -alow-downgrades
sudo apt-get -y autoremove
sudo apt-get clean
 }
