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
    instmods radeon uvesafb nouveau i915 amdgpu
}

install() {
     inst_binary /usr/bin/cut
     inst_binary /bin/grep
     inst_script "$moddir/select-video.sh" "/sbin/select-video.sh"
     inst_hook pre-pivot 50 "$moddir/system-video-blacklist.sh"
     inst_hook cmdline 50 "$moddir/parse-cmdline.sh"
     mkdir -p ${initdir}/etc/modprobe.d
     if [ -f /etc/modprobe.d/amdgpu.conf ]; then
           inst_multiple /etc/modprobe.d/amdgpu.conf
     fi
     if [ -f /etc/modprobe.d/vboxvideo.conf ]; then
           inst_multiple /etc/modprobe.d/vboxvideo.conf
     fi
}
