#!/bin/bash

# set -x
parted /dev/nvme0n1 mklabel gpt
parted /dev/nvme0n1 mkpart primary ext4 0GB 1GB
parted /dev/nvme0n1 mkpart primary ext4 1GB 100%

mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2

mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot

pacstrap -K /mnt base linux linux-firmware intel-ucode sudo vim curl grub efibootmgr networkmanager

arch-chroot /mnt
useradd -mG wheel -s /bin/bash d
grub-install --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
sleep 2
sed -i '125s/^#/ /' /etc/sudoers
echo "setxkbmap -option caps:escape_shifted_capslock" > /home/d/.xinitrc
echo "xrandr --output HDMI1 --above eDP1" >> /home/d/.xinitrc
echo "exec i3" >> /home/d/.xinitrc
echo "alias i='sudo pacman -S'" >> /home/d/.bashrc
echo "alias c='startx'" >> /home/d/.bashrc
