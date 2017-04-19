# piadvanced

## Thanks to the people of pihole-discourse and reddit. This is just a collection of other people's work in a nice package. I do not claim credit for anything other than creating this series of scripts.

* This is a custom install for my pi! I am a tinkerer, and when I tinker, I tend to break things!!!
* I started this as a much simpler script to help assist me in getting things back up and running as fast as possible.
* A few of these things are easily done with raspi-config,, but this streamlines the process.
* I am not a programmer, but I know enough to get into trouble.


## I will be updating this with new stuff all the time. you can always run git pull the /etc/piadvanced to download any changes.

## Here is what this bad boy does:

##### With some tweaking could work on debian devices that aren't raspberry pi's
#### This install will ask you many yes/no questions. If you don't want to install something, simply say NO!

#### This is set up like "modules" I plan on adding more pi projects to it later. If it can be automated, it should go here. Message me if you have any reccomendations to add.

### I suggest that you use the removedefaultpiuser script below.

### Makes backups of many of the default configuration files.

### Configures a strong firewall using iptables.
This is based on what you choose to install. All traffic to the pi is blocked unless there is a rule that allows the traffic.

Rules can be added/removed with sudo /etc/iptables.firewall.rules

### Some basic settings:
#### Set the time
* Set the timezone
* Change your NTP servers
* Add a script to update the time every half hour.
#### SSH
* on/off
* fail2ban
* psad
## Random Number Fix with rng-tools

### Memory
* Set the memory split.
* Use an experimental tweak to unlock 16MB of ram on the pi2 or pi3.

### Network interfaces
* Set the hostname
* Set a static ip for eth0
* Connect to wifi easily
* Set a static ip for wlan0

### MOTD tweak
For details see: https://github.com/deathbybandaid/pimotd

### Get's you up to date
#### Adds sources for debian stretch
#### Updates and Upgrades
#### Installs some basic programs
(if curious what it installs, look at the script files)

### Admin Mail
#### Apticron
#### Mail
These will allow you to set the pi to email you when it needs updates, or has successful cronjobs.

### Other Great Softwares
#### No-IP Dynamic Update Client
#### OpenVPN
#### Webmin
#### Usermin
#### xRDP
#### Rpi Monitor

### DNS Server Stuff
#### DNSMasq
* Gives the option to use the version 2.77test4.
#### Pi-Hole
* Asks you to change the password for the webui immediately.
* A dark theme, thanks to LKD70
* The Wally3k adlists.
  * Configure this with sudo nano /etc/pihole/adlists.list
* The Wally3k Block Page
  * Configure with sudo nano /var/phbp.ini
* The ability to bypass by mac address.
  * Configure with sudo nano /etc/dnsmasq.d/04-bypass.conf
* The ability to add additional interfaces to allow dnsmasq to listen on.
  * Configure with sudo nano /etc/dnsmasq.d/05-addint.conf
* The ability to add your Windows Active-Directory DNS.
  * Configure with sudo nano /etc/dnsmasq.d/06-activedirectory.conf
* The ability to add custom redirects.
  * Configure with sudo nano /etc/dnsmasq.d/07-customredirect.conf
  * and /etc/piadvanced/installscripts/customRedirect.list
* The ability to make pihole -up run every half-hour.
* The ability to make pihole -g run every 6 hours.
* The ability to remove stale lists once weekly.
* A way to Parse lists not compatible with Pihole.
  * Configure this with sudo nano /etc/piadvanced/installscripts/ublockpihole/lists.lst
#### DNSCrypt
(I haven't used the dnsmasq install yet)

### Webservers
With the webservers, you can set the ip address and ports to listen on.
#### Lightttpd
#### Apache
#### Nginx
* I have stuff in the works for nginx, stay tuned.


### Things I want to add:
* A wake-on-lan solution
* HTPC softwares, just the monitoring apps like plexpy, ombi, plexboard.
* Samba share
* A script that makes regular backups to a directory with date/time stamps. maybe weekly.
* If OpenVPN uses an IP of 10.8.0.1, can a webserver be run on that ip address?
* Running two instances of OpenVPN, and create a site-to-site connection.
* Make a script to revert changes.
* I want to try and automate the setup of the webservers
* Cerbot Let's Encrypt
* Privoxy
* Squid / Squidguard
* Setting up / mounting a usb device for permanent storage.
* Email server
* A way to load in a pihole teleport.
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
