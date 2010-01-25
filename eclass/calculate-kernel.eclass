# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: © 2007-2009 Mir Calculate, Ltd. 
# Purpose: Installing linux-desktop, linux-server. 
# Build the kernel from source.

inherit calculate eutils kernel-2
EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_preinst pkg_postinst pkg_postrm

IUSE="vmlinuz"

detect_version
detect_arch

CKV=$(get_version_component_range 1-3)
SLOT=$CKV
KV_FULL="${PV}-calculate"
CKV_FULL="${CKV}-calculate"

S="${WORKDIR}/linux-${KV_FULL}"
EXTRAVERSION="-calculate"

UNIPATCH_STRICTORDER=1

CALC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${PN}-${CKV}.tar.bz2
        ftp://mirror.yandex.ru/calculate/${PN}/${PN}-${CKV}.tar.bz2
		http://mirror.yandex.ru/calculate/${PN}/${PN}-${CKV}.tar.bz2
		ftp://ftp.linux.kiev.ua/pub/Linux/Calculate/${PN}/${PN}-${CKV}.tar.bz2"

#KERNEL_URI=`last_arg $KERNEL_URI`
#UNIPATCH_LIST_DEFAULT=""

SLOT_T="${PORTAGE_TMPDIR}/portage/${CATEGORY}/${PN}-${SLOT}/temp"

NEW_CALCULATE_OVERLAY="/var/lib/layman/calculate"
[[ -d ${ROOT}/${NEW_CALCULATE_OVERLAY} ]] &&
	CALCULATE_OVERLAY=${NEW_CALCULATE_OVERLAY} ||
	CALCULATE_OVERLAY="/usr/local/portage/layman/calculate"

CARCH=`arch`

KERNEL_CONFIG=
MODULESDBFILE=${ROOT}/var/lib/module-rebuild/moduledb

calculate-kernel_pkg_setup() {
	mkdir -p ${SLOT_T}
	kernel-2_pkg_setup
	local calculate_ini=${ROOT}/etc/calculate/calculate.ini
	[[ -e $calculate_ini ]] && \
		SYSTEM=$( cat $calculate_ini | sed -rn 's/system\=(.*)/\1/p' )
	[[ -n "$SYSTEM" ]] || SYSTEM=desktop
	[[ -n "$KERNEL_CONFIG" ]] || KERNEL_CONFIG="config-${SYSTEM}-${CARCH}-${CKV}"
	#detect current kernel dir
	[[ -e ${ROOT}/usr/src/linux ]] && 
		SRCLINUXLINK=$( readlink ${ROOT}/usr/src/linux )
}

calculate-kernel_src_unpack() {
	kernel-2_src_unpack
}

vmlinuz_src_compile() {
	local GENTOOARCH="${ARCH}"
	unset ARCH

	DEFAULT_KERNEL_SOURCE="${S}" CMD_KERNEL_DIR="${S}" genkernel \
		--kerneldir=${S} \
		--kernel-config=${WORKDIR}/config \
		--cachedir=${WORKDIR}/cache \
		--makeopts=${MAKEOPTS} \
		--tempdir=${S}/temp \
		--logfile=${WORKDIR}/genkernel.log \
		--bootdir=${WORKDIR}/boot \
		--no-save-config \
		--kernname=${SYSTEM} \
		--no-menuconfig \
		--clean \
		--mrproper \
		--no-cleartmp \
		--disklabel \
		--slowusb \
		--splash=tty1 \
		--all-ramdisk-modules \
		--unionfs \
		--module-prefix=${WORKDIR} \
		all || die "genkernel failed"
	
	einfo "kernel: >> Cleaning..."
	make clean &>/dev/null || die "cannot perform clean"
	ARCH="${GENTOOARCH}"
	mv ${WORKDIR}/boot/kernel-${SYSTEM}-*-${CKV_FULL} \
		${WORKDIR}/boot/vmlinuz-${KV_FULL}-installed
	mv ${WORKDIR}/boot/initramfs-${SYSTEM}-*-${CKV_FULL} \
		${WORKDIR}/boot/initramfs-${KV_FULL}-installed
	mv ${WORKDIR}/boot/System.map-${SYSTEM}-*-${CKV_FULL} \
		${WORKDIR}/boot/System.map-${KV_FULL}-installed
	cp ${S}/.config ${WORKDIR}/boot/config-${CKV_FULL}-installed
	cp ${S}/.config ${WORKDIR}/boot/config-${KV_FULL}-installed
	cp ${WORKDIR}/boot/System.map-${KV_FULL}-installed ${S}/System.map
	rm ${WORKDIR}/lib/modules/${CKV_FULL}/build
	rm ${WORKDIR}/lib/modules/${CKV_FULL}/source
}

calculate-kernel_src_compile() {
	export LDFLAGS=""
	mkdir -p ${WORKDIR}/boot
	cd ${S}
	cp ${ROOT}/${CALCULATE_OVERLAY}/profiles/kernel/${KERNEL_CONFIG} \
		${WORKDIR}/config || die "cannot copy kernel config"
	cp ${WORKDIR}/config ${S}/.config

	use vmlinuz && vmlinuz_src_compile
}

vmlinuz_src_install() {
	cd ${WORKDIR}
	insinto /
	doins -r boot
	insinto /usr/src
	cd ${WORKDIR}/lib
	insinto /lib
	doins -r modules
	insinto /tmp
	doins -r firmware
	cd ${WORKDIR}
	
	dosym /usr/src/linux-${KV_FULL} \
		"/lib/modules/${CKV_FULL}/source" ||
		die "cannot install source symlink"
	dosym /usr/src/linux-${KV_FULL} \
		"/lib/modules/${CKV_FULL}/build" || 
		die "cannot install build symlink"
}

calculate-kernel_src_install() {
	mv ${S}/.config ${WORKDIR}/config
	kernel-2_src_install
	use vmlinuz && vmlinuz_src_install
}

calculate-kernel_pkg_preinst() {
	PKG_CONTENTS=${ROOT}/var/db/pkg/${CATEGORY}/${PN}-${CKV}*/CONTENTS
	use vmlinuz && test -f ${PKG_CONTENTS} && calculate_rm_modules_dir ${PKG_CONTENTS}
}

calculate-kernel_pkg_postrm() {
	rm -f ${SLOT_T}/.alreadydel
	rmdir ${SLOT_T} &>/dev/null
	use vmlinuz && calculate_restore_kernel ${ROOT}/boot
}

vmlinuz_pkg_postinst() {
	calculate_update_kernel ${KV_FULL} ${ROOT}/boot
	cp -a ${ROOT}/tmp/firmware/* ${ROOT}/lib/firmware/
	rm -rf ${ROOT}/tmp/firmware
	calculate_update_depmod
	calculate_update_modules

	sed -ri 's/a:1:sys-fs\/aufs2/a:0:sys-fs\/aufs2/' $MODULESDBFILE
	if [[ $SRCLINUXLINK != linux-${CKV}*calculate ]]
	then
		ewarn "Perform command for update modules:"
		ewarn "  module-rebuild -X rebuild"
	fi
}

calculate-kernel_pkg_postinst() {
	#calculate_update_splash ${ROOT}/boot/initramfs-${SYSTEM}-${KV_FULL}
	kernel-2_pkg_postinst

	KV_OUT_DIR=${ROOT}/usr/src/linux-${KV_FULL}
	cp ${WORKDIR}/config ${KV_OUT_DIR}/.config

	cd ${KV_OUT_DIR}
	local GENTOOARCH="${ARCH}"
	unset ARCH
	ebegin "kernel: >> Running modules_prepare..."
	make modules_prepare &>/dev/null
	eend $? "Failed modules prepare"
	ARCH="${GENTOOARCH}"

	use vmlinuz && vmlinuz_pkg_postinst
}
