#!/bin/bash

# FORMAT
mkfs.ext4 /dev/nvme0n1p2
mkfs.vfat /dev/nvme0n1p1

# MOUNT
mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot

# BASE
pacstrap -K /mnt base linux linux-firmware intel-ucode base-devel vi vim sudo networkmanager grub efibootmgr

# EXTRA
xorg xorg-xinit i3 alacritty tmux chromium htop dmenu pipewire pipewire-alsa pipewire-pulse pipewire-jack brightnessctl fzf ranger exa tar jq bc rofi zip unzip cronie bluez bluez-utils noto-fonts

# DRIVERS
xf86-video-intel

libva-intel-driver
intel-media-driver

libva-utils => vainfo > check VA-API

# ADD USER + GRUB + INET
arch-chroot /mnt
useradd -mG wheel -s /bin/bash $USERNAME
grub-install --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
sed -i '125s/^#/ /' /etc/sudoers

# ADD USER + ENCRYPTED PASSWD TEST
useradd -mG wheel -s /bin/bash d
grub-install --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
sed -i '125s/^#/ /' /etc/sudoers
HASH="$6$cveWA8dx7.KxfTQK$vsOMthe24Kh8Ja2e6CG0C8GqYqUdSkteRr4GsEMLLFAW/Bu0lxX6XaxToE89t/ZqT9b/IBB3WcrtmxsckttjC/"
echo "root:$HASH" | chpasswd -e
echo "d:$HASH" | chpasswd -e
