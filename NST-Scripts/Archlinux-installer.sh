#!/bin/bash
# Melal's arch linux installer >><<




echo note that you need to partition your disk before running this script 

sleep 2 

while [[ true ]]; do
  echo "Your Cpu Model"
  # echo "1-AMD 2-INTEL 3-none"
  echo "1-AMD 2-INTEL "
  read CPU
  if [[ $CPU == "1" ]]; then
        CPU=amd
        break 
    elif [[ $CPU == "2" ]]; then
        CPU=intel
        break 
    # elif [[ ${CPU}=3 ]]; then
       # UCODE="0" 
    else
      echo "Please choose a number (1/2)"
      
    
  fi
done
echo " enter EFI paritition: (ex: sda1 )"
read EFI

echo " enter SWAP paritition: "
read SWAP

echo " enter main(/) paritition: "
read MAIN 

echo " enter your username"
read USER 

echo "Enter your root password"
read RPASSWORD

echo " enter your password"
read PASSWORD 
echo "-------------------------------------"
echo -e "\nParitioning ...\n"
echo "-------------------------------------"
mkfs.vfat -F32 /dev/$EFI
mkswap /dev/$SWAP
swapon /dev/$SWAP
mkfs.ext4 /dev/$MAIN

echo -e "\n Mounting .... \n"
mount /dev/$MAIN /mnt
efidir="boot/efi"
mkdir /mnt/$efidir
mount /dev/$EFI /mnt/$efidir


echo "--------------------------------------"
echo "-- Installing Arch Base --"
echo "--------------------------------------"

pacstrap /mnt linux linux-firmware base base-deve $CPU-ucode vim nvim --noconfirm --needed

echo "Creating fstab ...." 
genfstab -U /mnt >> /mnt/etc/fstab

cat <<REALEND > /mnt/Step2.sh

echo "----------------------------"
echo "---- Setting timezone ----"
echo "----------------------------"


ln -sf /usr/share/zoneinfo/Asia/Kuwait /etc/localtime 
hwclock --systohc 


echo "----------------------------"
echo "---- Locale ----"
echo "----------------------------"

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#ar_SA.UTF-8 UTF-8/ar_SA.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8"

echo " Enter the host name"
read HOSTNAME

echo "$HOSTNAME" >> /etc/hostname

cat<<END > /etc/hosts

127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain   $HOSTNAME
END

echo "----------------------------"
echo "---- Adding User .... ----"
echo "----------------------------"

useradd -mG wheel $USER
echo $USER:$PASSWORD
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo "----------------------------"
echo "---- Password .... ----"
echo "----------------------------"

echo root:$RPASSWORD | chpasswd

echo "----------------------------"
echo "---- Setup Dependencies ----"
echo "----------------------------"

IMPTDEB=grub efibootmgr networkmanager network-manager-applet git
pacman -S $IMPTDEB 

for IMPTDEB in "${IMPTDEB[@]}"; do
    echo "Successfully installed: $IMPTDEB"
done

# echo -e "\n What do you want to install ? \n"
#
# read DEBN
#
# while [[ true ]]; do
#  pacman -S $DEBN
# if [ $? -eq 0 ]; then
#   sleep 3
#     break
# else
#   
#     sleep 3
#     echo "check the spelling and try again"
# fi
#  
# done

echo "Do you want to install graphic driver (y/n)"
read GDA

while [[ true ]]; do
  
if [[ $GDA == "y" ]]; then
  echo "Nvidia , AMD , INTEL , VM   (1/2/3/4)"
  read GDA1 
  if [[  $GDA1 == "1" ]]; then
    pacman -S nvidia nvidia-utils
    mkinit="nvidia"
    break 
    elif [[ $GDA1 == "2" ]]; then
      pacman -S xf86-video-amd
      mkinit="amd"
      break 
    elif [[ $GDA1 == "3" ]]; then
      
      pacman -S xf86-video-intel
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

echo "----------------------------"
echo "---- Mkinitcpio ----"
echo "----------------------------"

if [[ $mkinit == "amd" ]]; then
  
  sed -i 's/^MODULES=()/MODULES=(amdgpu)/' /etc/mkinitcpio.conf
  mkinitcpio -p linux
  elif [[ $mkinit == "nvidia" ]]; then
    
  sed -i 's/^MODULES=()/MODULES=(nvidia)/' /etc/mkinitcpio.conf

  mkinitcpio -p linux
elif [[ $mkinit == "intel" ]]; then
  
  sed -i 's/^MODULES=()/MODULES=(i915)/' /etc/mkinitcpio.conf

  mkinitcpio -p linux
  else
    echo "Skipping .... "


fi

echo "----------------------------"
echo "---- Bootloader install (Grub) ----"
echo "----------------------------"

grub-install --target=x86_64-efi --efi-directory=$efidir --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
  
echo "----------------------------"
echo "---- Services enable ----"
echo "----------------------------"

systemctl enable networkmanager

echo "-------------------------------------------------"
echo "Install Complete, You can reboot now"
echo "-------------------------------------------------"

REALEND

arch-chroot /mnt sh Step2.sh


#1- partitioning the drive 
# tools : cfdisk -- 3 or 2 ( linux file system , Efi)
#
#2- mounting partitions 
# step 1 : mount /dev/-the system partition - /mnt
# step 2 : create a boot dir inside the /mnt -> mkdir -p /mnt/boot/efi
# step 3 : mount /dev/- the efi partition - /mnt/boot/efi


# 3- install the system 
# pacstrap /mnt base linux linux-firware vim amd-ucode git 
# 4- genfstab -U /mnt >> /mnt/etc/fstab

# 5 - arch-chroot /mnt


# --- setting the time zone --- 
#  To see all available timezones 
