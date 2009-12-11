# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

# @FUNCTION: calculate_update_kernel
# @USAGE: [kernelname] [kernelversion] [destination]
# @DESCRIPTION:
# Make symbolic link to vmlinuz, preserve old vmlinuz
# Copy initramfs to initrd and initrd-install
calculate_update_kernel() {
	kname=$1
	kversion=$2
	dir=$3

	# update vmlinuz
	[ -f ${dir}/vmlinuz ] && rm -f ${dir}/vmlinuz.old && 
		mv ${dir}/vmlinuz	${dir}/vmlinuz.old
	ln -sf "linux-${kname}-${kversion}-calculate" ${dir}/vmlinuz
	# update initrd
	[ -f ${dir}/initrd ] && rm -f ${dir}/initrd.old &&
		mv ${dir}/initrd ${dir}/initrd.old
	cp ${dir}/initramfs-${kname}-${kversion}-calculate ${dir}/initrd
	# update initrd-install
	[ -f ${dir}/initrd-install ] && rm -f ${dir}/initrd-install.old &&
		mv ${dir}/initrd-install ${dir}/initrd-install.old
	cp ${dir}/initramfs-${kname}-${kversion}-calculate ${dir}/initrd-install
}

TMP_INITRAMFS=${T}/initramfs
SPLASH_DESCRIPTOR=/etc/splash/tty1/1024x768.cfg

initramfs_unpack() {
	mkdir -p ${TMP_INITRAMFS}
	cd ${TMP_INITRAMFS}
	# select arch
	UNPACKER="gzip"
	lzma -dc ${BOOT_DIR}/$1 &>/dev/null && UNPACKER="lzma"
	# unpack initramfs
	gzip -dc ${BOOT_DIR}/$1 | cpio -di &>/dev/null
	return $?
}

initramfs_change_spalsh() {
	if [ -f ${SPLASH_DESCRIPTOR} ]
	then
		# get silentpic param
		SILENTPIC=$( sed -nr '/^silentpic/ s/^[^=]+=(.*)$/\1/p' \
			${SPLASH_DESCRIPTOR} )
		# get pic param
		PIC=$( sed -nr '/^pic/ s/^[^=]+=(.*)$/\1/p' \
			${SPLASH_DESCRIPTOR} )
		if [ -f ${SILENTPIC} ] && [ -f ${PIC} ]
		then
			cp ${SPLASH_DESCRIPTOR} \
					${TMP_INITRAMFS}${SPLASH_DESCRIPTOR} &&
				mkdir -p ${TMP_INITRAMFS}${SILENTPIC%$(basename $SILENTPIC)} &&
				cp $SILENTPIC ${TMP_INITRAMFS}${SILENTPIC} &&
				mkdir -p ${TMP_INITRAMFS}${PIC%$(basename $PIC)} &&
				cp $PIC ${TMP_INITRAMFS}${PIC}
			return $?
		fi
	else
		return 1
	fi
}

initramfs_pack() {
	# pack new initramfs
	cd ${TMP_INITRAMFS}
	find * | cpio -o --quiet -H newc | gzip -9 >${BOOT_DIR}/$1.new
	# remove old initramfs
	rm ${BOOT_DIR}/$1
	mv ${BOOT_DIR}/$1.new ${BOOT_DIR}/$1
}

# @FUNCTION: calculate_update_splash
# @USAGE: [initramfsfile]
# @DESCRIPTION:
# Install into initramfs splash data, which descripted by
# /etc/splash/tty1/1024x768.cfg
calculate_update_splash() {
	einfo "Update splash screen"
	initramfs_unpack $1 &&
	initramfs_change_spalsh && initramfs_pack $1
}
