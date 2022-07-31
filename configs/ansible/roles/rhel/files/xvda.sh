#!/bin/bash

sudo su

# //////////////////////////////////////////////////////////////////////////////////////////////////////
# XVDA
# INSTALL LVM TOOLS
yum install -y rsync lvm2

# MODIFY XVDA DISK TO 150GB (pg. 26)***
# modify /sys disk logical-disk xvda vg-reserved 150000
# lsblk

parted
u
s
p
rm 2
yes
ignore
p

vgcreate vgroot /dev/xvda3
lvcreate -n var -L 20G vgroot
lvcreate -n var_tmp -L 5G vgroot
lvcreate -n var_log -L 30G vgroot
lvcreate -n var_log_audit -L 1G vgroot
lvcreate -n tmp -L 5G vgroot
lvcreate -n home -l 100%FREE vgroot

mkfs.xfs /dev/mapper/vgroot-var
mkfs.xfs /dev/mapper/vgroot-var_tmp
mkfs.xfs /dev/mapper/vgroot-var_log

mkfs.xfs /dev/mapper/vgroot-var_log_audit
mkfs.xfs /dev/mapper/vgroot-tmp
mkfs.xfs /dev/mapper/vgroot-home

mount /dev/mapper/vgroot-var /mnt/
rsync -a /var/* /mnt/
ll -h /mnt/
umount /mnt/

mount /dev/mapper/vgroot-var_tmp /mnt/
rsync -a /var/tmp/* /mnt/
ll -h /mnt/
umount /mnt/

mount /dev/mapper/vgroot-var_log /mnt/
rsync -a /var/log/* /mnt/
ll -h /mnt/
umount /mnt/

mount /dev/mapper/vgroot-var_log_audit /mnt/
rsync -a /var/log/audit/* /mnt/
ll -h /mnt/
umount /mnt/

mount /dev/mapper/vgroot-tmp /mnt/
rsync -a /tmp/* /mnt/
ll -h /mnt/
umount /mnt/

mount /dev/mapper/vgroot-home /mnt/
rsync -a /home/* /mnt/
ll -h /mnt/
umount /mnt/

/dev/mapper/vgroot-var /var xfs defaults 0 0
/dev/mapper/vgroot-var_tmp /var/tmp xfs defaults,nodev,noexec,nosuid 0 0
/dev/mapper/vgroot-var_log /var/log xfs defaults 0 0
/dev/mapper/vgroot-var_log_audit /var/log/audit xfs defaults 0 0
/dev/mapper/vgroot-home /home xfs defaults,nodev 0 0
/dev/mapper/vgroot-tmp /tmp xfs defaults,noexec 0 0
none /dev/shm tmpfs defaults,nosuid,nodev,noexec,size=1G 0 0

mount -a
lsblk

# VERIFY SELINUX IS NOT ON ***
# vi /etc/sysconfig/selinux
# modify the line:  SELINUX=enforcing
# to SELINUX=disabled