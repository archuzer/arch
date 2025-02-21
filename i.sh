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

pacstrap -K /mnt base linux linux-firmware intel-ucode sudo vim grub efibootmgr networkmanager xorg xorg-xinit base-devel xf86-video-intel libva-intel-driver i3 alacritty chromium htop rofi


arch-chroot /mnt
useradd -mG wheel -s /bin/bash d
visudo
grub-install --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
#Section "Device"
#        Identifier "Intel Graphics"
#        Driver "intel"
#        Option "DRI" "iris"
#EndSection

#sed -i '58 s/^/#/' ~/.config/i3/config
#sed -i '60 s/^#//' ~/.config/i3/config
xrandr --output HDMI1 --above eDP1 > .xinitrc
exec i3 >> .xinitrc
