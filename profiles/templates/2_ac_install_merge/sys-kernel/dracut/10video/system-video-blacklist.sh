#!/bin/bash

if mount | grep " /sysroot " | grep ro, &>/dev/null
then
	mount -o rw,remount ${NEWROOT} &>/dev/null
	/sbin/select-video.sh ${NEWROOT}/etc/modprobe.d/video-blacklist.conf $videodrv
	mount -o ro,remount ${NEWROOT} &>/dev/null
else
	/sbin/select-video.sh ${NEWROOT}/etc/modprobe.d/video-blacklist.conf $videodrv
fi
