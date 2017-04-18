# DeathbybandaidPihole
This is a custom install for my pihole!

Feel free to fork this and make it your own!

## Instructions

git clone https://github.com/deathbybandaid/piadvanced.git /etc/piadvanced/

### Step one, we are going to change the root password.
##### If you are paranoid,,, make it something secure, use a password generator if needbe. Or simply don't be connected to a network for this step.

sudo passwd root

sudo bash /etc/piadvanced/removedefaultpiuser.sh

###### This will remove the root password we added earlier and lock the account.
passwd -dl root

sudo reboot

after it reboots, login as your new user.

### Step two, my main script here

sudo bash /etc/piadvanced/whaterveridecideon.sh
