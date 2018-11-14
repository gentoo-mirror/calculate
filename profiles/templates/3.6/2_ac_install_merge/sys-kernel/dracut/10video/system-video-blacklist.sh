#!/bin/bash

mount -o rw,remount ${NEWROOT} &>/dev/null
/sbin/select-video.sh ${NEWROOT}/etc/modprobe.d/video-blacklist.conf $videodrv
mount -o ro,remount ${NEWROOT} &>/dev/null
