WORKDIR=/home/sr/work/distro/build

cd $WORKDIR/indices
rm *
DIST=bionic
for SUFFIX in extra.main main main.debian-installer restricted restricted.debian-installer; do
  wget http://archive.ubuntu.com/ubuntu/indices/override.$DIST.$SUFFIX
done

cd $WORKDIR/ubuntu/disk
mkdir -p dists/stable/extras/binary-amd64
apt-ftparchive packages pool/extras > dists/stable/extras/binary-amd64/Packages
gzip -c dists/stable/extras/binary-amd64/Packages | tee dists/stable/extras/binary-amd64/Packages.gz > /dev/null
