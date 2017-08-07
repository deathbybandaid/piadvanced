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
timestamp=$(echo `date`)

printf "$blue"    "$DIVIDERBAR"
echo ""
printf "$cyan"   "$BNAMEPRETTYSCRIPTTEXT $timestamp"

## Log Section
echo "## $BNAMEPRETTYSCRIPTTEXT $timestamp" | tee --append $INSTALLATIONLOG &>/dev/null

if 
(whiptail --title "$BNAMEPRETTYSCRIPTTEXT" --yes-button "Skip" --no-button "Proceed" --yesno "$BNAMEPRETTYSCRIPTTEXT?" 10 80) 
then
echo "$CURRENTUSER Declined $BNAMEPRETTYSCRIPTTEXT" | sudo tee --append $INSTALLATIONLOG
echo ""$BNAMEPRETTYSCRIPTTEXT"install=no" | sudo tee --append $VARIABLESCONF
else
echo "$CURRENTUSER Accepted $BNAMEPRETTYSCRIPTTEXT" | sudo tee --append $INSTALLATIONLOG
echo ""$BNAMEPRETTYSCRIPTTEXT"install=yes" | sudo tee --append $VARIABLESCONF

## Run Script
bash $f

## End of install
fi

echo "" | tee --append $INSTALLATIONLOG &>/dev/null

printf "$magenta" "$DIVIDERBAR"
echo ""

## End Of Loop
done
