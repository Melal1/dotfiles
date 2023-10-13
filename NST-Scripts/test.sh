# sudo pacman -S sdfsdfsfazdsa
#
# # Check the exit status
# if [ $? -eq 0 ]; then
#     echo $?
#     echo "Command was successful"
# else
#     echo $?
#     echo "Command returned an error"
# fi
# read main
# echo "/etc/$main"
echo -e "\n What do you want to install ? \n"

read DEBN
   pacman -S $DEBN

while [[ true ]]; do
   if [ $? -eq 0 ]; then
       sleep 3
           break
         else
             
               sleep 3
                   echo "check the spelling and try again"
   fi
    
 done

