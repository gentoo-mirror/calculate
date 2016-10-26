# Calculate exec=/bin/sh cl_ebuild_phase!=&&cl_chroot_status==off&&cl_system_boot_set==off
rmmod vboxnetflt vboxnetadp 2>/dev/null
rmmod vboxdrv 2>/dev/null
modprobe -a vboxdrv vboxnetflt vboxnetadp
true
