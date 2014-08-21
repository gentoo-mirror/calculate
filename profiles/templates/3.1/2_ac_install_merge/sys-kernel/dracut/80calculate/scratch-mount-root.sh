# Calculate chmod=0755
#!/bin/sh
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

mount_live_root() {
    mkdir /run/initramfs/workspace
    mountoption="-o udba=reval,br:/run/initramfs/workspace=rw:/run/initramfs/squashfs=ro"
    if getargbool 0 scratch
    then
        mkdir /run/initramfs/delta
        mountoption="-o udba=reval,br:/run/initramfs/workspace=rw:/run/initramfs/delta=ro+wh:/run/initramfs/squashfs=ro"
    fi
    mount -t aufs $mountoption none $NEWROOT
    if getargbool 0 scratch
    then
        mkdir /run/builder
        mountoption="-o udba=reval,br:/run/initramfs/delta=rw:/run/initramfs/squashfs=ro"
        mount -t aufs $mountoption none /run/builder
    fi
}

[ -n "$root" -a -z "${root%%live*}" -o "$root" = "nfs" ] && mount_live_root
