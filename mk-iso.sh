
WORKDIR=/home/sr/work/distro/build
DISKDIR=$WORKDIR/ubuntu/disk

echo "copy config files"
rm -rf $DISKDIR/pool/extras
cp -r config/* $DISKDIR/

pushd $WORKDIR/ubuntu/disk
mkdir -p dists/stable/extras/binary-amd64
apt-ftparchive packages pool/extras > dists/stable/extras/binary-amd64/Packages
gzip -c dists/stable/extras/binary-amd64/Packages | tee dists/stable/extras/binary-amd64/Packages.gz > /dev/null


#mkisofs -D -r -V "Custom Ubuntu Install CD" \
#            -cache-inodes \
#            -J -l -b isolinux/isolinux.bin \
#            -c isolinux/boot.cat -no-emul-boot \
#            -boot-load-size 4 -boot-info-table \
#            -o $WORKDIR/distr.iso $DISKDIR

popd

xorriso -as mkisofs \
  -o distr.iso \
  -isohybrid-mbr myisohdpfx.bin \
  -c isolinux/boot.cat \
  -b isolinux/isolinux.bin \
  -no-emul-boot -boot-load-size 4 -boot-info-table \
  $DISKDIR
