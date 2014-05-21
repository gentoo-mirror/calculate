#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh
#
# Licensed under the GPLv2
#
# Copyright 2013 Red Hat, Inc.
# Peter Jones <pjones@redhat.com>

check() {
    return 255
}

depends() {
    return 0
}

installkernel() {
    instmods radeon uvesafb nouveau i915
}

install() {
#    inst_dir /lib/modules/keys
     inst_binary /usr/sbin/lspci
     inst_binary /usr/bin/sleep
     inst_binary /bin/grep
     inst_binary /sbin/lsmod
     inst_binary /usr/bin/find
     inst_binary /usr/bin/cut
     inst_simple /usr/share/misc/pci.ids
     inst_hook pre-trigger 01 "$moddir/load-video.sh"
     inst_hook cmdline 50 "$moddir/parse-cmdline.sh"
     mkdir -p ${initdir}/etc/modprobe.d
     for videomodule in fglrx nvidia radeon nouveau i915 uvesafb
     do
        echo "blacklist ${videomodule}" >>${initdir}/etc/modprobe.d/video-blacklist.conf
     done
#
#    inst_hook pre-trigger 01 "$moddir/load-modsign-keys.sh"
#
#    for x in /lib/modules/keys/* ; do
#        [[ "${x}" = "/lib/modules/keys/*" ]] && break
#        inst_simple "${x}"
#    done
}
