#!/bin/bash

# Check if the partition table is GPT; if not, create it
if ! parted /dev/nvme0n1 print | grep -q 'Partition Table: gpt'; then
  echo "Creating GPT partition table on /dev/nvme0n1..."
  parted /dev/nvme0n1 -- mklabel gpt
fi

# Remove existing partitions if any
for partition in /dev/nvme0n1p*; do
  if [ -e "$partition" ]; then
    echo "Removing existing partition $partition..."
    parted /dev/nvme0n1 -- rm $(basename $partition | sed 's/[^0-9]*//g')
  fi
done

parted /dev/nvme0n1 -- mkpart primary fat32 1MiB 1GiB
parted /dev/nvme0n1 -- set 1 boot on
parted /dev/nvme0n1 -- mkpart primary ext4 1GiB 100%

mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2

mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot

lsblk

echo "- Partitions created, formatted, and mounted successfully."
echo "- PACSTRAP"
pacstrap -K /mnt base linux linux-firmware intel-ucode sudo vim grub efibootmgr networkmanager xorg xorg-xinit base-devel xf86-video-intel libva-intel-driver intel-media-driver i3 alacritty chromium htop tmux rofi git fzf pipewire pipewire-alsa pipewire-pulse pipewire-jack inxi zip u
nzip thunar file-roller pavucontrol vlc
