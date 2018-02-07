# Calculate exec=/bin/bash cl_network_configure_set==off

rsync -a --delete --exclude net.lo --include "net.*" --exclude "*" /etc/init.d/ #-cl_chroot_path-#/etc/init.d/
rsync -a --delete --include "net.*" --exclude "*" /etc/runlevels/boot/ #-cl_chroot_path-#/etc/runlevels/boot/
rsync -a --delete --include "net.*" --exclude "*" /etc/runlevels/default/ #-cl_chroot_path-#/etc/runlevels/default/
true
