#!/bin/bash

# //////////////////////////////////////////////////////////////////////////////////////////////////////
# FIPS
# ENABLE FIPS 
cat > /tmp/fips.sh <<EOF
#!/bin/bash
yum -y install dracut-fips
yum -y install prelink
grep -qw aes /proc/cpuinfo && echo YES || echo no
#If the above returns YES, it would be beneficial (but not required) to install dracut-fips-aesni, e.g.:
yum -y install dracut-fips-aesni
rpm -q prelink && sed -i ‘/^PRELINKING/s,yes,no,’ /etc/sysconfig/prelink
rpm -q prelink && prelink -uav
mv -v /boot/initramfs-$(uname -r).img{,.bak}
dracut
grubby --update-kernel=$(grubby --default-kernel) --args=fips=1
uuid=$(findmnt --output=UUID -n -T /boot)
echo $uuid
# [[ -n $uuid ]] && grubby --update-kernel=$(grubby --default-kernel) --args=boot=UUID=${uuid}
EOF

chmod +x /tmp/fips.sh
bash /tmp/fips.sh

# # Set AFTER_REBOOT according to options (-r).
# if [ "x$AFTER_REBOOT" = "xyes" ]; then
#     sysctl crypto.fips_enabled
# else
#     # Before reboot
# fi
