#!/bin/bash

PKG=("xorg" "xorg-xinit" "feh" "xdg-user-dirs" "neofetch")

for pkg in "${PKG[@]}"; do
    echo Installing "$pkg" ....
    sudo pacman -S "$pkg" 

    
 done

 


