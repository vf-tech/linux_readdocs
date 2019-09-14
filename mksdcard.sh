#! /bin/sh

DRIVE=$1

echo $DRIVE Clean Starting.. Please wait..

dd if=/dev/zero of=$DRIVE bs=1M count=1024

SIZE=`fdisk -l $DRIVE | grep Disk | awk '{print $5}'`

echo DISK SIZE - $SIZE bytes

CYLINDERS=`echo $SIZE/255/63/512 | bc`

fdisk ${DRIVE} << EOF
n
p
1

+32M
t
c
a
n
p
2

+512M
w
EOF

mkfs.vfat -F 32 -n "boot" ${DRIVE}1
umount ${DRIVE}1
mkfs.ext3 -L "rootfs" ${DRIVE}2
umount ${DRIVE}2
