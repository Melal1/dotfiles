#!/bin/bash
# Melal's arch linux installer >><<


echo -ne "
-------------------------------------------------------------------------
                    Automated Arch Linux Installer
-------------------------------------------------------------------------

Setting up mirrors for optimal download
"
source $CONFIGS_DIR/setup.conf
iso=$(curl -4 ifconfig.co/country-iso)
timedatectl set-ntp true
pacman -S --noconfirm archlinux-keyring #update keyrings to latest to prevent packages failing to install
pacman -S --noconfirm --needed pacman-contrib terminus-font
# setfont ter-v22b
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
pacman -S --noconfirm --needed reflector rsync grub
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
echo -ne "
-------------------------------------------------------------------------
                    Setting up $iso mirrors for faster downloads
-------------------------------------------------------------------------
"
reflector -a 48 -c $iso -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist
mkdir /mnt &>/dev/null # Hiding error message if any


echo note that you need to partition your disk before running this script 

 

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

mkfs.vfat -F32 /dev/"${EFI}"
mkswap /dev/"${SWAP}"
swapon /dev/"${SWAP}"
mkfs.ext4 /dev/"${MAIN}"

sleep 1
echo -e "\n Mounting .... \n"
sleep 1
mount /dev/"${MAIN}" /mnt
efidir="boot/efi"
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/"${EFI}" /mnt/"${efidir}"

sleep 1
echo "--------------------------------------"
echo "-- Installing Arch Base --"
echo "--------------------------------------"
sleep 1

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


while true; do
  echo "Do you want to install a graphics driver (y/n)"
  read GDA

  if [[ $GDA == "y" ]]; then
    echo "Nvidia, AMD, INTEL, VM (1/2/3/4)"
    read GDA1

    case $GDA1 in
      "1")
        # pacman -S nvidia nvidia-utils
        mkinit="nvidia"
        break
        ;;
      "2")
        # pacman -S xf86-video-amd
        mkinit="amd"
        break
        ;;
      "3")
        # pacman -S xf86-video-intel
        mkinit="intel"
        break
        ;;
      "4")
        # grubcfg="true" # for future #TODO
        mkinit="VM"
        break
        ;;
      *)
        echo "You didn't select a valid value, please try again..."
        continue  # This allows the user to try again
        ;;
    esac
  elif [[ $GDA == "n" ]]; then
    echo "Okay, Skipping..."
    break
  else
    echo "Please select (y/n)"
  fi
done

pacstrap /mnt linux linux-firmware base base-devel "${CPU}"-ucode vim  --noconfirm --needed

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

cat <<END > /etc/hosts

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

IMPTDEB= "grub efibootmgr networkmanager network-manager-applet git"
pacman -S $IMPTDEB 

for IMPTDEB in "${IMPTDEB[@]}"; do
    echo "Successfully installed: $IMPTDEB"
    sleep 1
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




echo "----------------------------"
echo "---- Mkinitcpio ----"
echo "----------------------------"

if [[ "$mkinit" == "amd" ]]; then

  pacman -S xf86-video-amd
  sed -i 's/^MODULES=()/MODULES=(amdgpu)/' /etc/mkinitcpio.conf
  mkinitcpio -p linux

  elif [[ "$mkinit" == "nvidia" ]]; then

  pacman -S nvidia nvidia-utils 
  sed -i 's/^MODULES=()/MODULES=(nvidia)/' /etc/mkinitcpio.conf

  mkinitcpio -p linux

elif [[ "$mkinit" == "intel" ]]; then

  pacman -S xf86-video-intel
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
