#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Minsk /etc/localtime
hwclock --systohc --utc

sed -i '177s/.//' /etc/locale.gen
sed -i '404s/.//' /etc/locale.gen
locale-gen

echo "LANG=ru_RU.UTF-8" >> /etc/locale.conf
echo "LC_COLLATE=C" >> /etc/locale.conf

echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf

echo "ASUSLaptop-N580GD" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 ASUSLaptop-N580GD.localdomain ASUSLaptop-N580GD" >> /etc/hosts

pacman -S btrfs-progs intel-ucode networkmanager sudo grub efibootmgr os-prober nano ntfs-3g

mkdir /boot/efi
mount /dev/vda1 /boot/efi/
grub-install --target=x86_64-efi --efi-directory=/boot/efi/ --bootloader-id=ArchLinux --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

useradd -m elitornyx
echo elitornyx:password | chpasswd
usermod -aG libvirt elitornyx

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
