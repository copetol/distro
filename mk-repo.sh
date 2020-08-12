WORKDIR=/home/sr/work/distro/build


BUILD=$WORKDIR/ubuntu/disk
APTCONF=$WORKDIR/apt-ftparchive/release.conf
DISTNAME=focal

pushd $BUILD
apt-ftparchive -c $APTCONF generate $WORKDIR/apt-ftparchive/apt-ftparchive-deb.conf
apt-ftparchive -c $APTCONF generate $WORKDIR/apt-ftparchive/apt-ftparchive-udeb.conf
apt-ftparchive -c $APTCONF generate $WORKDIR/apt-ftparchive/apt-ftparchive-extras.conf
apt-ftparchive -c $APTCONF release $BUILD/dists/$DISTNAME > $BUILD/dists/$DISTNAME/Release

gpg --default-key "A5C7C2B7BC2C0163D89D47E66F191B5AFF6EC551" --output $BUILD/dists/$DISTNAME/Release.gpg -ba $BUILD/dists/$DISTNAME/Release
find . -type f -print0 | xargs -0 md5sum > md5sum.txt
popd
