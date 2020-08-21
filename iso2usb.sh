sudo umount /dev/sdb1
sudo umount /dev/sdb
sudo dd bs=4M if=distr.iso of=/dev/sdb status=progress oflag=sync
