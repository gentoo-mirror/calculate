# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit eutils linux-info

# @FUNCTION: last_arg
# @USING: last_arg manyarguments
# @DESCRIPTION:
# print last argument
last_arg() {
	shift $(( $# - 1 ))
	echo $1
}

# @FUNCTION: rm_link_with_file
# @USING: rm_link_with_file filename
# @DESCRIPTION:
# delete the file, and if it is symbolic then delete the file,
# which point out a link
rm_link_with_file() {
	[[ -L $1 ]] && rm -f `readlink -f $1`
	rm -f $1
}

# @FUNCTION: cp_link_with_file
# @USING: cp_link_with_file filename suffix
# @DESCRIPTION:
# copy the file with the same name with the suffix, and if it is a symbolic
# link, then also copy the target file with the addition of the suffix
cp_link_with_file() {
	if [[ -L $1 ]]
	then
		rm -f `readlink -f ${1}`$2
		cp -aH ${1} `readlink -f ${1}`$2
		ln -sf `readlink ${1}`${2} ${1}${2}
	else
		rm -f ${1}${2}
		cp -aH ${1} ${1}${2}
	fi
}

# @FUNCTION: make_old_file
# @USAGE: make_old_file filename 
# @DESCRIPTION:
# wear out a file, copy the file, adding its name suffix ". old"
# support symbolic link
make_old_file() {
	if [[ -e $1 ]]
	then
		rm_link_with_file $1.old
		cp_link_with_file $1 .old
	fi
	rm_link_with_file $1
}

# @FUNCTION: update_file
# @USAGE: wear_out_file filename link
# @DESCRIPTION:
# update a file from filename-installed, and make old file if need
update_file() {
	# if newest file is absent
	[[ -e $1-installed ]] || return 1
	# link and filename exist
	if [[ `readlink -f $2` == `readlink -f $1` ]]
	then
		make_old_file $2
	else
		# rename link to link.old
		mv $2 $2.old &>/dev/null
		# make old filename
		make_old_file $1
		# fix link pointed to previous filename
		find -lname "$1" -exec ln -sf $1.old {} \;
	fi
	# make link to filename
	ln -sf `basename $1` $2
	# rename installed
	mv $1-installed $1
}

# @FUNCTION: calculate_update_kernel
# @USAGE: [kernelname] [kernelversion] [destination]
# @DESCRIPTION:
# Make symbolic link to vmlinuz, preserve old vmlinuz
# Copy initramfs to initrd and initrd-install
calculate_update_kernel() {
	kversion=$1
	dir=$2

	# update vmlinuz
	update_file ${dir}/vmlinuz-${kversion} ${dir}/vmlinuz
	# update initrd
	update_file ${dir}/initramfs-${kversion} ${dir}/initrd
	# update initrd-install
	update_file ${dir}/initramfs-${kversion}-install ${dir}/initrd-install
	# update System.map
	update_file ${dir}/System.map-${kversion} ${dir}/System.map
	# update config-{KV_FULL}
	make_old_file ${dir}/config-${KV_FULL}
	mv ${dir}/config-${KV_FULL}-installed ${dir}/config-${KV_FULL}

	ebegin "Trying to optimize initramfs"
	( which calculate &>/dev/null && calculate --initrd ) && eend 0 || eend 1
	if [[ "$(md5sum ${ROOT}/boot/initrd | awk '{print $1}')" == \
		"$(md5sum ${ROOT}/boot/initrd-install | awk '{print $1}')" ]]
	then
		ewarn
		ewarn "Perform command after reboot for optimization initramfs:"
		ewarn "  calculate --initrd"
	fi
}

is_broken_link() {
	fname=$1
	[[ -n $( file $fname | grep "broken symbolic link" ) ]] &&
		return 0 ||	return 1
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
	lzma --force -t $1 &>/dev/null && UNPACKER="lzma"
	# unpack initramfs
	${UNPACKER} -dc $1 | cpio -di &>/dev/null
	return $?
}

initramfs_change_spalsh() {
	if [ -f ${ROOT}${SPLASH_DESCRIPTOR} ]
	then
		# get silentpic param
		SILENTPIC=$( sed -nr '/^silentpic/ s/^[^=]+=(.*)$/\1/p' \
			${ROOT}${SPLASH_DESCRIPTOR} )
		# get pic param
		PIC=$( sed -nr '/^pic/ s/^[^=]+=(.*)$/\1/p' \
			${ROOT}${SPLASH_DESCRIPTOR} )
		if [ -f ${ROOT}${SILENTPIC} ] && [ -f ${ROOT}${PIC} ]
		then
			cp ${ROOT}${SPLASH_DESCRIPTOR} \
					${TMP_INITRAMFS}${SPLASH_DESCRIPTOR} &&
				mkdir -p ${TMP_INITRAMFS}${SILENTPIC%$(basename $SILENTPIC)} &&
				cp ${ROOT}${SILENTPIC} ${TMP_INITRAMFS}${SILENTPIC} &&
				mkdir -p ${TMP_INITRAMFS}${PIC%$(basename $PIC)} &&
				cp ${ROOT}$PIC ${TMP_INITRAMFS}${PIC}
			return $?
		fi
	else
		return 1
	fi
}

initramfs_pack() {
	# pack new initramfs
	cd ${TMP_INITRAMFS}
	find * | cpio -o --quiet -H newc | gzip -9 >$1.new
	# remove old initramfs
	if [[ $? -eq 0 ]]
	then
		rm $1
		mv $1.new $1
	fi
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

# FUNCTION: calculate_update_modules
# DESCRIPTION:
# It calls the update-modules utility. Get from linux-mod.
calculate_update_modules() {
	if [ -x /sbin/update-modules ] && \
		grep -v -e "^#" -e "^$" "${D}"/etc/modules.d/* >/dev/null 2>&1; then
		ebegin "Updating modules.conf"
		/sbin/update-modules
		eend $?
	elif [ -x /sbin/update-modules ] && \
		grep -v -e "^#" -e "^$" "${D}"/etc/modules.d/* >/dev/null 2>&1; then
		ebegin "Updating modules.conf"
		/sbin/update-modules
		eend $?
	fi
}

# FUNCTION: calculate_update_depmod
# DESCRIPTION:
# It updates the modules.dep file for the current kernel.
# Get from linux-mod.
calculate_update_depmod() {
	# if we haven't determined the version yet, we need too.
	get_version;

	ebegin "Updating module dependencies for ${KV_FULL}"
	if [ -r "${KV_OUT_DIR}"/System.map ]
	then
		depmod -ae -F "${KV_OUT_DIR}"/System.map -b "${ROOT}" -r ${KV_FULL}
		eend $?
	else
		ewarn
		ewarn "${KV_OUT_DIR}/System.map not found."
		ewarn "You must manually update the kernel module dependencies using depmod."
		eend 1
		ewarn
	fi
}

# FUNCTION: calculate_clean_firmwares
# DESCRIPTION:
# Workaround kernel issue with collising
# firmwares across different kernel versions
calculate_clean_firmwares() {
	for fwfile in `find "${ROOT}/tmp/firmware" -type f`; do
		sysfile="${ROOT}/lib/${fwfile/${ROOT}/tmp/}"
		if [ -f "${sysfile}" ]; then
			#ewarn "Removing duplicated: ${sysfile}"
			rm ${sysfile} || die "failed to remove ${sysfile}"
		fi
	done
}
