# Calculate chmod=0755
#!/bin/sh
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

mount_live_root_aufs() {
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

mount_live_root_overlay() {
    lowerdir=/run/initramfs/squashfs
    if getargbool 0 scratch
    then
        upperdir=/run/initramfs/delta
        builderdir=/run/builder
        mkdir $upperdir
        mkdir $builderdir
        mkdir ${upperdir}-workdir
        mount -t overlay -o lowerdir=${lowerdir},upperdir=${upperdir},workdir=${upperdir}-workdir none $builderdir
        lowerdir=$builderdir
    fi
    upperdir=/run/initramfs/workspace
    mkdir ${upperdir}
    mkdir ${upperdir}-workdir
    mount -t overlay -o lowerdir=${lowerdir},upperdir=${upperdir},workdir=${upperdir}-workdir none $NEWROOT
}

mount_live_root() {
    if find /lib/modules/ | grep -q overlayfs
    then
        mount_live_root_overlay
    else
        mount_live_root_aufs
    fi
}

[ -n "$root" -a -z "${root%%live*}" -o "$root" = "nfs" ] && mount_live_root
