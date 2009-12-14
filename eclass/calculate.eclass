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
	ln -sf initramfs-${kname}-${kversion}-calculate ${dir}/initrd
	# update System.map
	[ -f ${dir}/System.map ] && rm -f ${dir}/System.map.old &&
		mv ${dir}/System.map ${dir}/System.map.old
	ln -sf System.map-${kname}-${kversion}-calculate ${dir}/System.map
	ebegin "Trying to optimize initramfs"
	( which calculate &>/dev/null && calculate ) && eend 0 || eend 1
}

is_broken_link() {
	return [[ -n $( file $1 | grep "broken symbolic link" ) ]]
}

# @FUNCTION: calculate_restore_kernel
# @USAGE: [destination]
# @DESCRIPTION:
# Restore vmlinux.old and initrd.old in destination
calculate_restore_kernel() {
	dir=$1

	# restore vmlinuz
	is_broken_link ${dir}/vmlinuz && [ -f ${dir}/vmlinuz.old ] &&
		mv ${dir}/vmlinuz.old ${dir}/vmlinuz

	# resotre initrd
	is_broken_link ${dir}/initrd && [ -f ${dir}/initrd.old ] &&
		mv ${dir}/initrd.old ${dir}/initrd

	# restore System.map
	is_broken_link ${dir}/System.map && [ -f ${dir}/System.map.old ] &&
		mv ${dir}/System.map.old ${dir}/System.map
}

TMP_INITRAMFS=${T}/initramfs
SPLASH_DESCRIPTOR=/etc/splash/tty1/1024x768.cfg

# @FUNCTION: calculate_rm_modules_dir
# @USAGE: [CONTENTS]
# @DESCRIPTION:
# Remove installed files from lib/modules specified by CONTENTS file.
# For work need specify and create SLOT_T directory for .alreadydel flag file,
# which determined was or not file removing.
calculate_rm_modules_dir() {
	PKG_CONTENTS=$1
	[[ -f ${SLOT_T}/.alreadydel ]] && return 0 || 
		touch ${SLOT_T}/.alreadydel &>/dev/null
	addwrite "/lib/modules"
	DIRRM=$( sed -rn '/^dir.*lib\/modules/ s/^\S+\s+(\S+)\s*.*$/\1/p' \
		${PKG_CONTENTS} | sort -r)
	FILERM=$( sed -rn '/^(obj|sym).*lib\/modules/ s/^\S+\s+(\S+)\s+.*$/\1/p' ${PKG_CONTENTS} )
	if [[ -n ${FILERM} ]]
	then
		for f in ${FILERM}
		do
			rm -f $f 
		done
	fi
	if [[ -n ${DIRRM} ]]
	then
		for f in ${DIRRM}
		do
			rmdir $f &>/dev/null
		done
	fi
}

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

# @FUNCTION: calculate_set_kernelversion
# @USAGE: KERNEL_DIR
# @DESCRIPTION:
# Change version in Makefile of kernel sources on version specified by
# variables KV_MAJOR KV_MINOR KV_PATCH KV_TYPE
calculate_set_kernelversion() {
	KERNEL_DIR=$1
	sed -ri "s/^VERSION = .*$/VERSION = $KV_MAJOR/" \
		${KERNEL_DIR}/Makefile
	sed -ri "s/^PATCHLEVEL = .*$/PATCHLEVEL = $KV_MINOR/" \
		${KERNEL_DIR}/Makefile
	sed -ri "s/^SUBLEVEL = .*$/SUBLEVEL = $KV_PATCH/" \
		${KERNEL_DIR}/Makefile
	sed -ri "s/^EXTRAVERSION = .*$/EXTRAVERSION = $KV_TYPE/" \
		${KERNEL_DIR}/Makefile
}
