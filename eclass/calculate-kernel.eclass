# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: © 2007-2009 Mir Calculate, Ltd. 
# Purpose: Installing linux-desktop, linux-server. 
# Build the kernel from source.

inherit calculate eutils kernel-2 linux-mod
EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_postinst pkg_postrm pkg_prerm

SRC_URI="x86? 
		( ftp://ftp.calculate.ru/pub/calculate/${PN}/${PN}-i686-${PV}.tar.bz2 )
		amd64?
		( ftp://ftp.calculate.ru/pub/calculate/${PN}/${PN}-x86_64-${PV}.tar.bz2	)"
SLOT="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
GENTOO_SOURCES_PV="${SLOT}"
GENTOO_SOURCES_PVR="${GENTOO_SOURCES_PV}-${GENTOO_SOURCES_PR}"
SRC_NAME=linux-${GENTOO_SOURCES_PV}-gentoo-${GENTOO_SOURCES_PR}
KV_FULL="${SLOT}${KV_TYPE}"
SLOT_T="${PORTAGE_TMPDIR}/portage/${CATEGORY}/${PN}-${SLOT}/temp"

DEPEND="=sys-kernel/gentoo-sources-${GENTOO_SOURCES_PVR}"
RDEPEND="${DEPEND}"

calculate-kernel_pkg_setup() {
	mkdir -p ${SLOT_T}
}

calculate-kernel_src_unpack() {
	unpack ${PN}-`arch`-${PV}.tar.bz2

	#unpack ${A}
}

calculate-kernel_src_compile() {
	cd ${WORKDIR}
	addwrite "/usr/src/"
	cp -Rpt ${ROOT}/usr/src/ usr/src/*

	calculate_set_kernelversion ${ROOT}/usr/src/${SRC_NAME}
	rm ${ROOT}/usr/src/linux
	ln -sf ${SRC_NAME} ${ROOT}/usr/src/linux
	cd ${ROOT}/usr/src/linux
	local GENTOOARCH="${ARCH}"
	[[ ${ARCH} = x86 ]] && ARCH=i686 || unset ARCH
	make modules_prepare
	ARCH="${GENTOOARCH}"

	cd ${WORKDIR}
}

calculate-kernel_src_install() {
	dodir /usr/src/${SRC_NAME}
	insinto /
	doins -r boot
	doins -r lib
	
	dosym /usr/src/${SRC_NAME} \
		"/lib/modules/${GENTOO_SOURCES_PV}-calculate/source" ||
		die "cannot install source symlink"
	dosym /usr/src/${SRC_NAME} \
		"/lib/modules/${GENTOO_SOURCES_PV}-calculate/build" || 
		die "cannot install build symlink"

	addwrite "/lib/firmware"
	# Workaround kernel issue with colliding
	# firmwares across different kernel versions
	for fwfile in `find "${D}/lib/firmware" -type f`; do

		sysfile="${ROOT}/${fwfile/${D}}"
		if [ -f "${sysfile}" ]; then
			#ewarn "Removing duplicated: ${sysfile}"
			rm ${sysfile} || die "failed to remove ${sysfile}"
		fi

	done
		
	PKG_CONTENTS=${ROOT}/var/db/pkg/${CATEGORY}/${PN}-${SLOT}*/CONTENTS
	test -f ${PKG_CONTENTS} && calculate_rm_modules_dir ${PKG_CONTENTS}
}

calculate-kernel_pkg_prerm() {
	calculate_rm_modules_dir ${ROOT}/var/db/pkg/${CATEGORY}/${PF}/CONTENTS
}

calculate-kernel_pkg_postinst() {
	calculate_update_splash ${ROOT}/boot/initramfs-${SYSTEM}-${SLOT}-calculate
	calculate_update_kernel ${SYSTEM} ${SLOT} ${ROOT}/boot
	KV_OUT_DIR=/usr/src/${SRC_NAME}

	kernel-2_pkg_postinst
	UPDATE_MODULEDB=false
	linux-mod_pkg_postinst
}

calculate-kernel_pkg_postrm() {
	rm -f ${SLOT_T}/.alreadydel
	rmdir ${SLOT_T} &>/dev/null
	calculate_restore_kernel ${ROOT}/boot
}

