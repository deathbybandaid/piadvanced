#!/bin/sh
## This ties the Networking Scripts together

## Variables
script_dir=$(dirname $0)
source "$script_dir"/scriptvars/variables.var

## Start File Loop
## For .sh files In The mainscripts Directory
for f in $ALLTOPLEVELSCRIPTS
do

# Dynamic Variables
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
BASEFILENAMEDASHNUM=$(echo $BASEFILENAME | sed 's/[0-9\-]/ /g')
BNAMEPRETTYSCRIPTTEXT=$(echo $BASEFILENAMEDASHNUM)

## Loop Variables
SCRIPTTEXT=""$BNAMEPRETTYSCRIPTTEXT"."
timestamp=$(echo `date`)

printf "$blue"    "$DIVIDERBAR"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"

## Log Section
#echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null

###
###
### Correlate whatitdoes with the name of the module somehow
###
###

{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 10 80) 
then
echo "$CURRENTUSER Declined $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=no" | sudo tee --append /etc/piadvanced/install/variables.conf
else
echo "$CURRENTUSER Accepted $NAMEOFAPP" | sudo tee --append /etc/piadvanced/install/installationlog.txt
echo ""$NAMEOFAPP"install=yes" | sudo tee --append /etc/piadvanced/install/variables.conf

## Run Script
bash $f

#echo "" | sudo tee --append $RECENTRUN

## End of install
fi }

printf "$magenta" "$DIVIDERBAR"
echo ""

## End Of Loop
done
