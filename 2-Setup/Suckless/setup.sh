#!/bin/bash
echo -ne "
-------------------------------------------------------------------------

  ▄▄▄▄███▄▄▄▄      ▄████████  ▄█          ▄████████  ▄█      
▄██▀▀▀███▀▀▀██▄   ███    ███ ███         ███    ███ ███      
███   ███   ███   ███    █▀  ███         ███    ███ ███      
███   ███   ███  ▄███▄▄▄     ███         ███    ███ ███      
███   ███   ███ ▀▀███▀▀▀     ███       ▀███████████ ███      
███   ███   ███   ███    █▄  ███         ███    ███ ███      
███   ███   ███   ███    ███ ███▌    ▄   ███    ███ ███▌    ▄
 ▀█   ███   █▀    ██████████ █████▄▄██   ███    █▀  █████▄▄██
                             ▀                      ▀        
-------------------------------------------------------------------------
          Suckless Setup Script 
	  Run this script after a clean install 
------------------------------------------------------------------------



"









echo -ne "
-------------------------------------------------------------------------
                          Installing Display Server
-------------------------------------------------------------------------
"

 PKG=("xorg" "xorg-xinit" ) 

for pkg in "${PKG[@]}"; do
    echo 'Installing "$pkg" ....' 
    sudo pacman -S "$pkg" 

    
done



echo -ne "
-------------------------------------------------------------------------
                          Installing Suckless Programs
-------------------------------------------------------------------------
"

cd $HOME/dotfiles/2-Setup/Suckless/dmenu 
sudo make clean install 

cd $HOME/dotfiles/2-Setup/Suckless/dwm
sudo make clean install 


cd $HOME/dotfiles/2-Setup/Suckless/dwm
sudo make clean install 

source $HOME/dotfiles/2-Setup/Suckless/Assest.conf



echo -ne "
-------------------------------------------------------------------------
                          Installing Additional Packages 
-------------------------------------------------------------------------
"

fn_dpen() {
echo -ne "Do you want a minimalist install ? (y/n) "
read An

if [[ "$An" == "y" ]] ; then 
	echo "okay skipping ..."
	
elif [[ "$An" == "n" ]] ; then 
	sudo pacman -S "${DPN[@]}" 

else 
	echo -ne  "
       
	Invalid option , please choose (y/n)
       
	"
	fn_dpen
fi 

}

fn_dpen


echo -ne "
-------------------------------------------------------------------------
                          Installing Audio Server
-------------------------------------------------------------------------
"


echo sudo pacman -S "${pipewire[@]}"
