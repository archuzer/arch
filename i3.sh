sudo pacman -S xorg xorg-xinit base-devel sed chromium firefox libva-intel-driver vulkan-intel i3 alacritty brightnessctl ranger htop tmux rofi git fzf pipewire pipewire-alsa pipewire-pulse pipewire-jack inxi zip unzip thunar file-roller pavucontrol vlc ffmpeg xf86-video-intel

mkdir -p /home/d/.config/i3
cp /etc/i3/config /home/d/.config/i3/config
sleep 1
chown d:d /home/d/.config/i3/config
sed -i '58 s/^/#/' /home/d/.config/i3/config
sed -i '60 s/^#//' /home/d/.config/i3/config
