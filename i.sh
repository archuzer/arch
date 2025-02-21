#!/bin/bash

# Print every line that executes
set -x

lsblk

read -n 1 -s -r -p "Press any key to continue..."
parted /dev/nvme0n1 mklabel gpt mkpart primary ext4 0GB 1GB mkpart primary ext4 1GB 100%
read -n 1 -s -r -p "Press any key to continue..."

mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
read -n 1 -s -r -p "Press any key to continue..."

mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
lsblk
read -n 1 -s -r -p "Press any key to continue..."

pacstrap -K /mnt base linux linux-firmware intel-ucode sudo vim grub efibootmgr networkmanager xorg xorg-xinit base-devel xf86-video-intel libva-intel-driver intel-media-driver vulkan-intel i3 alacritty chromium htop tmux rofi git fzf pipewire pipewire-alsa pipewire-pulse pipewire-jack inxi zip unzip thunar file-roller pavucontrol vlc
