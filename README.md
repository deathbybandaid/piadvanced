# piadvanced
This is a custom install for my pi! I am a tinkerer, and when I tinker, I tend to break things!!!

I started this as a much simpler script to help assist me in getting things back up and running as fast as possible.

## Here is what this bad boy does:

##### With some tweaking could work on debian devices that aren't raspberry pi's
#### This install will ask you many yes/no questions. If you don't want to install something, simply say NO!

#### This is set up like "modules" I plan on adding more pi projects to it later. If it can be automated, it should go here. Message me if you have any reccomendations to add.

### Configures a strong firewall using iptables.
This is based on what you choose to install. All traffic to the pi is blocked unless there is a rule that allows the traffic.

Rules can be added by sudo /etc/iptables.firewall.rules

### 


### Get's you up to date
#### Adds sources for debian stretch
#### Updates and Upgrades
#### Installs some basic programs
(if curious what it installs, look at the script files)

### Admin Mail
#### Apticron
#### Mail

These will allow you to set the pi to email you when it needs updates, or has successful cronjobs.

### DNS Server Stuff
#### DNSMasq
#### Pi-Hole
##### This included some tweaks for dnsmasq.
* A dark theme, thanks to LKD70
* The Wally3k Block Page
  * Configure with sudo nano /var/phbp.ini
* The ability to bypass by mac address.
  * Configure with sudo nano /etc/dnsmasq.d/04-bypass.conf
* The ability to add additional interfaces to allow dnsmasq to listen on.
  * Configure with sudo nano /etc/dnsmasq.d/05-addint.conf
* The ability to add your Windows Active-Directory DNS.
  * Configure with sudo nano /etc/dnsmasq.d/06-activedirectory.conf

#### DNSCrypt
(I haven't used the dnsmasq install yet)

### Webservers
#### Lightttpd
#### Apache
#### Nginx
* I am working on getting Certbot going with this.
* as well as automated assistance setting up nginx,, maybe apache.



### Things I want to add:
* HTPC softwares
* Privoxy
* Squid / Squidguard
* Setting up / mounting a usb device for permanent storage.
* Email server
* Since the install uses multiple variables, it may be possible to make a secondary script for an ultra-fast re-install (using the same variable) on the same device with the same device.

## Instructions

sudo git clone https://github.com/deathbybandaid/piadvanced.git /etc/piadvanced/

### Step one, we are going to change the root password.
##### If you are paranoid,,, make it something secure, use a password generator if needbe. Or simply don't be connected to a network for this step.

sudo passwd root

sudo bash /etc/piadvanced/removedefaultpiuser.sh

###### This will remove the root password we added earlier and lock the account.
passwd -dl root

sudo reboot

after it reboots, login as your new user.

### Step two, my main script here

sudo bash /etc/piadvanced/extendedinstall.sh
