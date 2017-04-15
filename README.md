# DeathbybandaidPihole
This is a custom install for my pihole!

Feel free to fork this and make it your own!

## Instructions

Step one, we are going to change the root password.

sudo passwd root

##### make it something secure,, use a password generator if needbe.

wget https://raw.githubusercontent.com/deathbybandaid/DeathbybandaidPihole/master/removedefaultpiuser.sh -P /home/

chmod +x removedefaultpiuser.sh

bash removedefaultpiuser.sh
