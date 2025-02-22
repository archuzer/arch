parted /dev/nvme0n1 mklabel gpt
parted /dev/nvme0n1 mkpart primary ext4 0GB 1GB
parted /dev/nvme0n1 mkpart primary ext4 1GB 100%

mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
