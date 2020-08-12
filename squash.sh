WORKDIR=/home/sr/work/distro/build
SQ_ROOT=$WORKDIR/squashfs/squashfs-root
KR_DIR=$WORKDIR/keyring/ubuntu-keyring/keyrings

UAKR=ubuntu-archive-keyring.gpg


cp $KR_DIR/$UAKR $SQ_ROOT/usr/share/keyrings/$UAKR
cp $KR_DIR/$UAKR $SQ_ROOT/etc/apt/trusted.gpg
cp $KR_DIR/$UAKR $SQ_ROOT/var/lib/apt/keyrings/$UAKR
cp $WORKDIR/keyring/ubuntu-keyring*deb $WORKDIR/ubuntu/disk/pool/main/u/ubuntu-keyring/

exit

cd $SQ_ROOT
rm ../new-filesystem.size
rm ../new-filesystem.squashfs

du -sx --block-size=1 ./ | cut -f1 > ../new-filesystem.size
mksquashfs ./ ../new-filesystem.squashfs

cp ../new-filesystem.size $WORKDIR/ubuntu/disk/install/filesystem.size
cp ../new-filesystem.squashfs $WORKDIR/ubuntu/disk/install/filesystem.squashfs

