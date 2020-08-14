umount /dev/sdb1
dd bs=4M if=../build/distr.iso of=/dev/sdb status=progress oflag=sync
