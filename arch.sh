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
		  user="${USER1,,}"
			break
     else 
		 echo "Incorrect username , check that username complies with username rules"
    fi
done 


read -r -p "Enter hostname : " HOSTNAME
echo -ne "\n"

sec_password() {
  read -r -p "Enter your password : " PASS1
  echo -ne "\n"
  read -r -p "Re-enter your password : " PASS2
  if [[ "$PASS1" == "$PASS2" ]] ; then 
      PASS="$PASS1"
   else
    echo -ne "- ERROR !! - Passwords don't match . \n"
     sec_password
  fi
}

sec_password


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
          GPU="NVIDIA"
        elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
          # pacman -S --noconfirm --needed xf86-video-amdgpu
          GPU="AMD"
        elif grep -E "Integrated Graphics Controller" <<< ${gpu_type}; then
        # pacman -S --noconfirm --needed libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
          GPU="INTEL-IN"
        elif grep -E "Intel Corporation UHD" <<< ${gpu_type}; then
        # pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
          GPU="INTEL-EX"
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

cat <<REALEND > /mnt/2-Setup.sh
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
                             2-Setup
-------------------------------------------------------------------------
"
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
  # ln -sf /usr/share/zoneinfo/"$timezone" /etc/localtime 

  elif [[ "$timezone_answer" == "n" ]]; then
  
  sure () {
    echo -ne "Please write your time zone ( Ex: Asia/Kuwait ) : \n"
    read -r TIMEZONE 

    echo -ne "Your timezone will be set to '$TIMEZONE' \n Continue ? (y/n) : \n"
    read -r continue

    if [[ "${continue}" == "y" ]]; then
      echo -ne "Setting your timezone to $TIMEZONE"
      # ln -sf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime
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

REALEND

arch-chroot /mnt sh 2-Setup.sh
