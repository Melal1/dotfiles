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
"


# from christitus script 
echo -ne "
-------------------------------------------------------------------------
                    ArchLinux Installer
                    NOTE : you need to partition
                    your disk before run this script 
-------------------------------------------------------------------------

Setting up mirrors for optimal download
"
sleep 3
# source $CONFIGS_DIR/setup.conf
iso=$(curl -4 ifconfig.co/country-iso)
pacman -Syyu
timedatectl set-ntp true
pacman -S --noconfirm archlinux-keyring #update keyrings to latest to prevent packages failing to install
# setfont ter-v22b
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
pacman -S --noconfirm --needed reflector 
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
echo -ne "
-------------------------------------------------------------------------
                    Setting up $iso mirrors for faster downloads
-------------------------------------------------------------------------
"
reflector -a 48 -c $iso -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist
mkdir /mnt &>/dev/null # Hiding error message if any

echo -ne "
-------------------------------------------------------------------------
                     Create file system
-------------------------------------------------------------------------
"


read -r -p "Enter the efi partition (Ex: sda1) : " EFI
mkfs.vfat -F32 -n "EFI" /dev/"$EFI"
echo -ne "\n"

read -r -p "Enter the swap partition : " SWAP
mkswap /dev/"$SWAP"
swapon /dev/"$SWAP"
echo -ne "\n"

read -r -p "Enter the root(/) partition : " MAIN
mkfs.ext4 -L "root" /dev/"$MAIN"

echo -ne "
-------------------------------------------------------------------------
                    Mounting
-------------------------------------------------------------------------
"
mount /dev/"$MAIN" /mnt

echo -ne "Mounted /dev/"$MAIN" with /mnt"
boot="boot/efi"
echo "boot=${boot}" >> /mnt/var.conf
mkdir -p /mnt/"$boot"
echo -ne "Created /mnt/$boot "
mount /dev/"$EFI" /mnt/"$boot"
echo -ne "Mounted /dev/"$EFI" with /mnt"

echo -ne "Done !!"

echo -ne "\n"
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
          Please select presetup settings for your system
-------------------------------------------------------------------------
"



while true
 do 
		read -p "Enter username : " USER1
		# username regex per response here https://unix.stackexchange.com/questions/157426/what-is-the-regex-to-validate-linux-users
		# lowercase the username to test regex
		if [[ "${USER1}" =~ ^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$ ]] ; then
		  echo "USER=${USER1,,}" >> /mnt/var.conf
			break
     else 
		 echo "Incorrect username , check that username complies with username rules"
    fi
done 


read -r -p "Enter hostname : " HOSTNAME
echo "HOSTNAME=${HOSTNAME}" >> /mnt/var.conf
echo -ne "\n"

sec_password() {
  read -r -p "Enter your password : " PASS1
  echo -ne "\n"
  read -r -p "Re-enter your password : " PASS2
  if [[ "$PASS1" == "$PASS2" ]] ; then 
      echo "PASS=${PASS1}" >>  /mnt/var.conf 
   else
    echo -ne "- ERROR !! - Passwords don't match . \n"
     sec_password
  fi
}

sec_password

echo -ne "
-------------------------------------------------------------------------
                          Setting timezone 
-------------------------------------------------------------------------
"

timezone=$(curl --fail https://ipapi.co/timezone)
echo -ne "------------------------------------------------------------------------------------------ \n"

timezone () {
echo -ne "\n Your timezone is '$timezone' , is that right ? (y/n) : \n"
read -r timezone_answer 

if [[ "$timezone_answer" == "y" ]] ; then
  echo -ne "Setting your time zone to '$timezone' "
  echo "TIMEZONE=${timezone}" >> /mnt/var.conf

  # ln -sf /usr/share/zoneinfo/"$timezone" /etc/localtime 

  elif [[ "$timezone_answer" == "n" ]]; then
  
  sure() {
    echo -ne "Please write your time zone ( Ex: Asia/Kuwait ) : \n"
    read -r TIMEZONE 

    echo -ne "Your timezone will be set to '$TIMEZONE' \n Continue ? (y/n) : \n"
    read -r continue

    if [[ "${continue}" == "y" ]]; then
      echo -ne "Setting your timezone to $TIMEZONE"
      echo "TIMEZONE=${TIMEZONE}" >> /mnt/var.conf
      else
        sure
    fi

  }

    sure
  else
    echo -ne "\n Please select (y/n) \n"
    timezone
fi 
}
timezone

echo -ne "
-------------------------------------------------------------------------
                    Determine Microcode
-------------------------------------------------------------------------
"
# determine processor type and install microcode
cpu_type=$(lscpu)
if grep -E "GenuineIntel" <<< ${cpu_type}; then
    echo "Installing Intel microcode"
    CPU="intel"
    
elif grep -E "AuthenticAMD" <<< ${cpu_type}; then
    echo "Installing AMD microcode"
    CPU="amd"
    
fi



echo -ne "
-------------------------------------------------------------------------
                    Determine Graphics Drivers
-------------------------------------------------------------------------
"

sec_vm() {
read -r -p "Are you on virtual machine ? (y/n) : " VM
if [[ "$VM" == "y" ]] ; then 
    echo -ne "Skipping ..."
    sleep 1
  elif [[ "$VM" == "n" ]]; then 
      gpu_type=$(lspci)
      if grep -E "NVIDIA|GeForce" <<< ${gpu_type}; then
          # pacman -S --noconfirm --needed nvidia
          echo "GPU=NVIDIA" >> /mnt/var.conf
          GPKG=("nvidia")
        elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
          # pacman -S --noconfirm --needed xf86-video-amdgpu
          echo "GPU=AMD" >> /mnt/var.conf
          GPKG=("xf86-video-amdgpu")
        elif grep -E "Integrated Graphics Controller" <<< ${gpu_type}; then
        # pacman -S --noconfirm --needed libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
          echo "GPU=INTEL" >> /mnt/var.conf
          GPKG=("libva-intel-driver" "libvdpau-va-gl" "lib32-vulkan-intel" "vulkan-intel" "libva-intel-driver" "libva-utils" "lib32-mesa")

        elif grep -E "Intel Corporation UHD" <<< ${gpu_type}; then
        # pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
          echo "GPU=INTEL" >> /mnt/var.conf
          GPKG=("libva-intel-driver" "libvdpau-va-gl" "lib32-vulkan-intel" "vulkan-intel" "libva-intel-driver" "libva-utils" "lib32-mesa")
        else
          echo "Please choose (y/n)"
          sec_vm
       fi
fi
}
sec_vm


echo -ne "
-------------------------------------------------------------------------
                        Installing Arch Base
-------------------------------------------------------------------------
"

pacstrap /mnt linux linux-firmware base base-devel "${CPU}"-ucode vim  --noconfirm --needed

PKG=("grub" "efibootmgr" "networkmanager" "git" "${GPKG[@]}")
# PKG2=("${GPKG[@]}")
echo -ne "
-------------------------------------------------------------------------
                          Create fstab
-------------------------------------------------------------------------
"

genfstab -u /mnt >> /mnt/etc/fstab


echo -ne "
-------------------------------------------------------------------------
                   Your SYSTEM is Ready for 2-Setup
-------------------------------------------------------------------------
"

cat <<'REALEND' > /mnt/2-Setup.sh

source ./var.conf
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
                             2-Setup
-------------------------------------------------------------------------
"
 ln -sf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime
 hwclock --systohc
echo -ne "
-------------------------------------------------------------------------
                          Setting Locale 
-------------------------------------------------------------------------
"

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#ar_SA.UTF-8 UTF-8/ar_SA.UTF-8 UTF-8/' /etc/locale.gen
locale-gen



echo "$HOSTNAME" >> /etc/hostname

cat <<END > /etc/hosts

127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain   $HOSTNAME
END

echo -ne "
-------------------------------------------------------------------------
                          Adding User 
-------------------------------------------------------------------------
"

groupadd libvirt
useradd -m -G wheel,libvirt -s /bin/bash $USER

sleep 3

echo "$USER created, home directory created, added to wheel and libvirt group, default shell set to /bin/bash"

echo $USER:$PASS | chpasswd


# Add sudo no password rights
# sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers




echo "----------------------------"
echo "---- Setup Dependencies ----"
echo "----------------------------"


# pacman -S --noconfirm "${PKG[@]}"

# pacman -S --noconfirm "${PKG2[@]}"
# trying to fix the error 

sudo  pacman -S grub efibootmgr networkmanager git 



# for pkg in "${PKG[@]}"; do
#     Installing "$pkg"
#     # sudo pacman -S --noconfirm "$pkg"
#     sudo pacman -S "$pkg"
#     sleep 3
    
# done




echo "----------------------------"
echo "---- Mkinitcpio ----"
echo "----------------------------"

if [[ "$GPU" == "AMD" ]]; then

  pacman -S xf86-video-amd
  sed -i 's/^MODULES=()/MODULES=(amdgpu)/' /etc/mkinitcpio.conf
  mkinitcpio -p linux

  elif [[ "$GPU" == "NVIDIA" ]]; then

  pacman -S nvidia nvidia-utils 
  sed -i 's/^MODULES=()/MODULES=(nvidia)/' /etc/mkinitcpio.conf

  mkinitcpio -p linux

elif [[ "$GPU" == "INTEL" ]]; then

  pacman -S xf86-video-intel
  sed -i 's/^MODULES=()/MODULES=(i915)/' /etc/mkinitcpio.conf

  mkinitcpio -p linux

else
    echo "Skipping .... "


fi

echo "----------------------------"
echo "---- Bootloader install (Grub) ----"
echo "----------------------------"

grub-install --target=x86_64-efi --efi-directory=/$boot --bootloader-id="GRUB"
grub-mkconfig -o /boot/grub/grub.cfg
  
echo "----------------------------"
echo "---- Services enable ----"
echo "----------------------------"

systemctl enable NetworkManager

echo "-------------------------------------------------"
echo "Install Complete, You can reboot now"
echo "-------------------------------------

REALEND

arch-chroot /mnt sh 2-Setup.sh
