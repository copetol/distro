#!/bin/bash

# arguments:
#   <path to iso-file> [ onlycopy ]
#   OR
#   skipcopy


#apt-get -y install squashfs-tools fakeroot

WORKDIR=/home/sr/work/distro/build
CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WDIR=$WORKDIR/ubuntu
CFGDIR=$CURDIR/config
EXTRADIR=$CURDIR/extra-pkgs

DISKDIR=$WDIR/disk
MNTDIR=$WDIR/mnt

################################################## check arguments
if test "$#" -lt 1; then
  echo "need path to iso file or 'skipcopy' as an argument"
  exit
fi
################################################## copy disk

if test "$1" != "skipcopy"; then
  mkdir -p  $DISKDIR $MNTDIR
  ISOPATH=$1
  echo "mount iso $ISOPATH to copy disk content"
  sudo mount -o loop $ISOPATH $MNTDIR
  #rsync --exclude=/casper/filesystem.squashfs -av $MNTDIR/ $DISKDIR
  echo "copy disk content"
  rsync -av $MNTDIR/ $DISKDIR
  #cp -rT $MNTCD $DISK
  sudo umount $MNTDIR
  sudo chmod -R +w $DISKDIR
fi
if test "$2" == "onlycopy"; then
  exit
fi
################################################## copy config files
echo "copy config files"
cp -r $CFGDIR/* $DISKDIR/
##################################################
#SQUASHFSDIR=$WDIR/squashfs
#mkdir -p $SQUASHFSDIR
#cd $SQUASHFSDIR
#unsquashfs $DISKDIR/install/filesystem.squashfs
#cd squashfs-root
#cp $DISKDIR/
#cd $DISKDIR

#exit 0

##ARCHDIR=$DISKDIR/dists/stable/extras/binary-amd64
##mkdir -p $ARCHDIR
####apt-ftparchive packages $DISKDIR/pool/extras > $ARCHDIR/Packages
####gzip -c $ARCHDIR/Packages | tee $ARCHDIR/Packages.gz > /dev/null
#apt-ftparchive packages ${EXTRAS_POOL} | gzip > ${EXTRAS_DIST}/Packages.gz

#apt-ftparchive release -c $DISKDIR/dists/stable > $DISKDIR/dists/stable/Release


#echo "Make indices"
#rm -rf ./indices
#mkdir -p indices
#cd indices
#DIST=xenial
## for SUFFIX in extra.main main main.debian-installer restricted restricted.debian-installer; do
##  wget http://archive.ubuntu.com/ubuntu/indices/override.$DIST.$SUFFIX
##done

#cd ..

###APTCONF=./apt-release.conf
###FTPARCHDIR=ftp-archive
###mkdir -p $FTPARCHDIR

###apt-ftparchive -c $APTCONF generate $FTPARCHDIR/apt-ftparchive-deb.conf
###apt-ftparchive -c $APTCONF generate $FTPARCHDIR/apt-ftparchive-udeb.conf
###apt-ftparchive -c $APTCONF generate $FTPARCHDIR/apt-ftparchive-extras.conf
###apt-ftparchive -c $APTCONF release $DISKDIR/dists/stable > $DISKDIR/dists/stable/Release

#echo "Calculating md5 sums"
#find $DISKDIR -type f -print0 | xargs -0 md5sum > $WORKDIR/md5sum.txt

#xorriso -as mkisofs -r -V "Custom Ubuntu Install CD" \
#            -cache-inodes \
#            -J -l -b isolinux/isolinux.bin \
#            -c isolinux/boot.cat -no-emul-boot \
#            -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
#            -eltorito-alt-boot \
#            -e boot/grub/efi.img \
#            -isohybrid-gpt-basdat \
#            -boot-load-size 4 -boot-info-table \
#            -o distr.iso $DISKDIR

#echo "Add extra packages"
#cd $EXTRADIR && dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz && cp -r $EXTRADIR $DISKDIR/dists/stable/


#./extra-pkgs.sh $EXTRADIR && cp -r $EXTRADIR $DISKDIR/dists/

echo "Starting mkisofs..."
mkisofs -D -r -V "Custom Ubuntu Install CD" \
            -cache-inodes \
            -J -l -b isolinux/isolinux.bin \
            -c isolinux/boot.cat -no-emul-boot \
            -boot-load-size 4 -boot-info-table \
            -o $WORKDIR/distr.iso $DISKDIR

