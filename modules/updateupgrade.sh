#! / Bin / sh
## Updates
{Whiptail --msgbox "I'm going to run updates." 20 70 1
Sudo apt-get -y install
Sudo apt-get -y update --fix-missing
Sudo apt-get -y dist-upgrade -alow-downgrades
Sudo apt-get -y autoremove
Sudo apt-get clean
 }
