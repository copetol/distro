WORKDIR=/home/sr/work/distro/build
DISKDIR=$WORKDIR/ubuntu/disk

cd $WORKDIR/ubuntu/disk
mkdir -p dists/stable/extras/binary-amd64
apt-ftparchive packages pool/extras > dists/stable/extras/binary-amd64/Packages
gzip -c dists/stable/extras/binary-amd64/Packages | tee dists/stable/extras/binary-amd64/Packages.gz > /dev/null


mkisofs -D -r -V "Custom Ubuntu Install CD" \
            -cache-inodes \
            -J -l -b isolinux/isolinux.bin \
            -c isolinux/boot.cat -no-emul-boot \
            -boot-load-size 4 -boot-info-table \
            -o $WORKDIR/distr.iso $DISKDIR
