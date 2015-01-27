#!/bin/sh
# fixes an asynchronous problem with lvm/dracut while resuming
# for details see https://bugzilla.redhat.com/show_bug.cgi?id=830447

. /lib/dracut-lib.sh
info "TuxOnIce lvmfix started"

udevadm settle --timeout=30

info "TuxOnIce udev should be now fully settled"

return 0

