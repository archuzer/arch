#!/bin/bash

# Print every line that executes
set -x

parted /dev/nvme0n1 mklabel gpt
parted /dev/nvme0n1 mkpart primary ext4 0GB 1GB
parted /dev/nvme0n1 mkpart primary ext4 1GB 100%
lsblk
sleep 5
mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
lsblk
sleep 5
mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
lsblk
sleep 5

pacstrap -K /mnt base linux linux-firmware intel-ucode sudo vim curl grub efibootmgr networkmanager xorg xorg-xinit base-devel libva-intel-driver intel-media-driver vulkan-intel i3 alacritty chromium htop tmux rofi git fzf pipewire pipewire-alsa pipewire-pulse pipewire-jack inxi zip unzip thunar file-roller pavucontrol vlc xf86-video-intel

arch-chroot /mnt
#useradd -mG wheel -s /bin/bash d
#sed -i visudo
#grub-install --efi-directory=/boot
#grub-mkconfig -o /boot/grub/grub.cfg
#systemctl enable NetworkManager
#Section "Device"
#        Identifier "Intel Graphics"
#        Driver "intel"
#        Option "DRI" "iris"
#EndSection

#sed -i '58 s/^/#/' ~/.config/i3/config
#sed -i '60 s/^#//' ~/.config/i3/config
sed -i '125s/^#/ /' /mnt/etc/sudoers
echo "xrandr --output HDMI1 --above eDP1" > /mnt/home/d/.xinitrc
echo "exec i3" >> /mnt/home/d/.xinitrc
