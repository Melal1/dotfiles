
echo "Do you want to install graphic driver (y/n)"
read GDA

while [[ true ]]; do
  
if [[ $GDA == "y" ]]; then
  echo "Nvidia , AMD , INTEL , VM   (1/2/3/4)"
  read GDA1 
  if [[  $GDA1 == "1" ]]; then
    pacman -Ss nvidia nvidia-utils
    mkinit="nvidia"
    break 
    elif [[ $GDA1 == "2" ]]; then
      pacman -Ss xf86-video-amd
      mkinit="amd"
      break 
    elif [[ $GDA1 == "3" ]]; then
      
      pacman -Ss xf86-video-intel
      mkinit="intel"
      break 
      elif [[ $GDA1 == "4" ]]; then
        
        grubcfg="true" # for future #TODO
        break 
        
      else

        echo "you didn't select a valid value , Skipping ..."
        break 

  fi
  elif [[ $GDA == "n" ]]; then
    echo "okay , Skipping .."

    break 
  else
    echo "Please select (y/n)"
    
fi
done
echo $mkinit
