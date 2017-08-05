#!/bin/bash
## This is the central script that ties the others together

## Variables
script_dir=$(dirname $0)
source "$script_dir"/scriptvars/variables.var

## Logo
bash $AVATARSCRIPT

## Whiptail Required
bash $WHIPTAILDEP

## Here we Go!!
echo "This is The Deathbybandaid Pi Install" > herewego_textbox
whiptail --textbox --title "Let's Start!" herewego_textbox 10 80

####
#### Suggest running on the device
####

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

## Run Script
bash $f

#echo "$TAGTHEREPOLOG" | sudo tee --append $RECENTRUN &>/dev/null
#echo "" | sudo tee --append $RECENTRUN

printf "$magenta" "$DIVIDERBAR"
echo ""

## End Of Loop
done
