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





# xdg-user-dirs xdg-utils alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh acpi acpi_call tlp reflector

# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings  nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader lib32-opencl-nvidia opencl-nvidia libxnvctrl  
# pacman -Syu lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader libva-intel-driver xf86-video-intel

mkdir /boot/efi
mount /dev/sda1 /boot/efi/
grub-install --target=x86_64-efi --efi-directory=/boot/efi/ --bootloader-id=ArchLinux --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

useradd -m elitornyx
echo elitornyx:password | chpasswd
usermod -aG libvirt elitornyx

echo "elitornyx ALL=(ALL) ALL" >> /etc/sudoers.d/elitornyx


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
