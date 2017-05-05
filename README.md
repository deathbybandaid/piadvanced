# piadvanced

### Thanks to the people of pihole-discourse and reddit. This is just a collection of other people's work in a nice package. I do not claim credit for anything other than creating this series of scripts.

* This is a custom install for my pi! I am a tinkerer, and when I tinker, I tend to break things!!!
* I started this as a much simpler script to help assist me in getting things back up and running as fast as possible.
* A few of these things are easily done with raspi-config,, but this streamlines the process.
* I am not a programmer, but I know enough to get into trouble.

##### With some tweaking could work on debian devices that aren't raspberry pi's

### I will be updating this with new stuff all the time. you can always run git pull the /etc/piadvanced to download any changes.

# Here is what this half MB bad boy does:

#### This install:
* Will ask you many yes/no questions. If you don't want to install something, simply say NO!
* Is set up like "modules" I plan on adding more pi projects to it later. If it can be automated, it should go here. Message me if you have any reccomendations to add.

### I suggest that you use the removedefaultpiuser script below. This will bolster your pi's security by not using the default username.

## Makes backups of many of the default configuration files.
* You can find the backups in /etc/piadvanced/backups

## Configures a strong firewall using iptables.
* This is based on what you choose to install.
* All traffic to the pi is blocked unless there is a rule that allows the traffic.
  * Rules can be added/removed with sudo /etc/iptables.firewall.rules

## Some basic settings:

### Set the time
* Set the timezone
* Change your NTP servers
* Add a script to update the time every half hour.

### SSH
* on/off
* fail2ban
  * Helps protect against brute-force attempts.
  * Configure for other services by sudo nano /etc/fail2ban/jail.conf
* psad

### Random Number Fix with rng-tools
* Greatly helps when the system needs to randomize something.

### Memory
* Set the memory split.
* Use an experimental tweak to unlock 16MB of ram on the pi2 or pi3.

### Network interfaces
* Set the hostname
* Set a static ip for eth0
* Connect to wifi easily
* Set a static ip for wlan0

## MOTD tweak
* This makes the login message much nicer than a bloc of text
  * For details see: https://github.com/deathbybandaid/pimotd

## Get's your system up to date
#### Adds sources for debian stretch
#### Updates and Upgrades
#### Installs some basic programs and dependencies.
(if curious what it installs, look at the script files)

# Admin Mail
Handy if you want to get email from your device when things happen, or you need updates.
* Apticron
* Mail
* Exim4

## Dynamic Domain Name Services
* No-IP DUC (Dynamic Update Client)
* DDClient, which I believe works with dyndns

## VPN
  * Port 1194 defualt
* OpenVPN
* piVPN

## Administration Web UI's
* Webmin
  * Port 10000
* Usermin
  * Port 20000
* Rpi Monitor
  * Port 8889

## xRDP
* This let's you remote-in to your pi, using the Windows native Remote Desktop program.
  * I have found this handy when fail2ban locks me out due to invalid password attempts.

## DNSMasq
* Gives the option to use the version 2.77test4.

## DNSCrypt
This is fully functional, and works!

## Pi-Hole
* https://pi-hole.net/
* Asks you to change the password for the webui immediately.
* A dark theme, thanks to LKD70
  * NOTE: DOES NOT WORK WITH Pi-Hole 3.0 update.
  * Refer to https://github.com/lkd70/PiHole-Dark for details.
* The Wally3k adlists.
  * Configure this with sudo nano /etc/pihole/adlists.list
* The Wally3k Block Page
  * Refer to https://github.com/WaLLy3K/Pi-hole-Block-Page for details.
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
* The ability to set permanent static ip's. Helpful if your re-install often
  * Configure with sudo nano /etc/dnsmasq.d/08-staticip.conf
* The ability to block a mac address from recieving an IP address.
  * Configure with sudo nano /etc/dnsmasq.d/09-noip4you.conf
* The ability to make pihole -up run every half-hour.
* The ability to make pihole -g run every 6 hours.
* The ability to remove stale lists once weekly.
* A way to Parse lists not compatible with Pihole.
  * Configure this with sudo nano /etc/piadvanced/piholetweaks/ublockpihole/lists.lst
* A Second way to parse lists.
  * Configure with sudo nano /var/www/html/admin/parser.php
* A way to tweet daily blockings.
  * Configure this with sudo nano /etc/piadvanced/piholetweaks/piholetweeter.py
  * Credit goes to https://github.com/DarthKeizer/Pi-Hole-stats-tweeter
* HenningVanRaumle's Youtube Adblock List

## Webservers
With the webservers, you can set the ip address and ports to listen on. This helps with port conflict issues.
* Lightttpd
* Apache
* Nginx
  * I have stuff in the works for nginx, stay tuned.

## Guacamole
* Refer to https://guacamole.incubator.apache.org/
* Set up a RDP/VNC/Gateway for your home network.
* It runs on Tomcat using Port 8080
* The default username and password is guacadmin

## Proxy programs
  * These have the potential of being setup to function transparently alongside pihole.
* Privoxy
* Squid/Squidguard

## CUPS
* https://www.cups.org/
* This is probably the nicest printer server software out there.

## AtoMiC-ToolKit
* Refer to https://github.com/htpcBeginner/AtoMiC-ToolKit for more information.
* Anything that is installed by this will need a firewall rule added.

## Dplatform
* See https://github.com/DFabric/DPlatform-ShellCore for details.

## HASS
* See https://github.com/home-assistant/fabric-home-assistant for details.
* I had to cobble the installation a bit to make sure dependencies worked.
* I also have it set to remove the reboot instruction from their install script.
* I can't guarantee success on this one, my success has been hit or miss.

## Things in the works:
* Steam Cache
* PXE Server
* Moboticz
* Nagios
* OpenVAS
* ShellinaBox
* Plexboard
* A wake-on-lan solution
* Samba share
* A script that makes regular backups to a directory with date/time stamps. maybe weekly.
* Cerbot Let's Encrypt
* Setting up / mounting a usb device for permanent storage.
* Email server
* A way to load in a pihole teleport.

# Instructions

sudo git clone https://github.com/deathbybandaid/piadvanced.git /etc/piadvanced/

### The main script

sudo bash /etc/piadvanced/extendedinstall.sh

### Optional Step, we are going to change the root password.
##### If you are paranoid,,, make it something secure, use a password generator if needbe. Or simply don't be connected to a network for this step.

sudo passwd root

sudo bash /etc/piadvanced/renamedefaultpiuser.sh

###### This will remove the root password we added earlier and lock the account.
passwd -dl root

sudo reboot

after it reboots, login as your new user.

# Enjoy
