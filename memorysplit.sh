## This sets the memory split.
{ if (whiptail --yesno "Let's set the memory split." 8 78) then
{ NEWMEM_SPLIT=$(whiptail --inputbox "Do you plan on running headless? If so, set the memory split to 16." 20 60 "16" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo sed -i '/gpu_mem/ d' /boot/config.txt
sudo echo "gpu_mem=$NEWMEM_SPLIT" | sudo tee --append /boot/config.txt
fi }
else
echo ""
fi }

## This is an experimental tweak to unlock the pi's missing 16MB
whiptail --msgbox "This is The Deathbybandaid Pihole Install" 20 70 1
{ if (whiptail --yesno "Do you want to try the experimental unlock of an extra 16MB. This is for the Pi2 and Pi3 only" 8 78) then

else
echo ""
fi }

total_mem=1024


{ NEWMEM_SPLIT=$(whiptail --inputbox "Do you plan on running headless? If so, set the memory split to 16." 20 60 "16" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
sudo sed -i "s/\($gpu_mem *= *\).*/\1$116/"  /boot/config.txt
fi }




## This sets the memory split down to 16
#{ if (whiptail --yesno "Do you plan on running headless? This will set the memory split to 16." 8 78) then
#sudo sed -i "s/\($gpu_mem *= *\).*/\1$116/"  /boot/config.txt
#else
#echo ""
#fi }
