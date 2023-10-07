#!/bin/bash


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
