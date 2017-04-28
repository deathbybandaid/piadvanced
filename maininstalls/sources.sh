#!/bin/sh
## Sources
{ if (whiptail --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to install sources?" 8 78) then
echo "User Declined Dependencies"
else
{ whiptail --msgbox "I'm going to add sources ." 20 70 1 
sudo mkdir /etc/piadvanced/backups/sources
sudo sed -i '/repozytorium.mati75.eu/d' /etc/apt/sources.list
sudo sed -i '/mirrordirector.raspbian.org/d' /etc/apt/sources.list.d/stretch.list
sudo sed -i '/APT::Default-Release "jessie";/d' /etc/apt/apt.conf.d/99-default-release
sudo cp /etc/apt/sources.list /etc/piadvanced/backups/sources/
sudo cp /etc/apt/apt.conf.d/99-default-release /etc/piadvanced/backups/sources/
sudo cp /etc/apt/sources.list.d/stretch.list /etc/piadvanced/backups/sources/
sudo echo 'deb http://repozytorium.mati75.eu/raspbian jessie-backports main contrib non-free' | sudo tee --append /etc/apt/sources.list
sudo echo 'deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi' | sudo tee --append /etc/apt/sources.list.d/stretch.list
sudo echo 'APT::Default-Release "jessie";' | sudo tee --append /etc/apt/apt.conf.d/99-default-release
sudo gpg --keyserver pgpkeys.mit.edu --recv-key CCD91D6111A06851
sudo gpg --armor --export CCD91D6111A06851 | apt-key add -
sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
sudo wget https://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -
 }
fi }
