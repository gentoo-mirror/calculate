# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
inherit calculate kernel-2 linux-mod

DESCRIPTION="Binary kernel including the Gentoo patchset for the 2.6 kernel tree"
HOMEPAGE="http://www.calculate-linux.org/linux-desktop"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${PN}-`arch`-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE=""

KV_MAJOR=2
KV_MINOR=6
KV_PATCH=31
KV_TYPE=-calculate
SLOT="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
GENTOO_SOURCES_PV="${SLOT}"
GENTOO_SOURCES_PR="r9"
GENTOO_SOURCES_PVR="${GENTOO_SOURCES_PV}-${GENTOO_SOURCES_PR}"
SRC_NAME=linux-${GENTOO_SOURCES_PV}-gentoo-${GENTOO_SOURCES_PR}
SYSTEM="server"
KV_FULL="${SLOT}${KV_TYPE}"
SLOT_T="${PORTAGE_TMPDIR}/portage/${CATEGORY}/${PN}-${SLOT}/temp"

DEPEND="=sys-kernel/gentoo-sources-${GENTOO_SOURCES_PVR}
		>=sys-apps/calculate-1.3.3"
RDEPEND="${DEPEND}"

pkg_setup() {
	mkdir -p ${SLOT_T}
}

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${WORKDIR}
	addwrite "/usr/src/"
	cp -Rpt ${ROOT}/usr/src/ usr/src/*

	calculate_set_kernelversion ${ROOT}/usr/src/${SRC_NAME}
	rm ${ROOT}/usr/src/linux
	ln -sf ${SRC_NAME} ${ROOT}/usr/src/linux
	cd ${ROOT}/usr/src/linux
	make modules_prepare
	cd ${WORKDIR}
}

src_install() {
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
			ewarn "Removing duplicated: ${sysfile}"
			rm ${sysfile} || die "failed to remove ${sysfile}"
		fi

	done
		
	PKG_CONTENTS=${ROOT}/var/db/pkg/${CATEGORY}/${PN}-${SLOT}*/CONTENTS
	test -f ${PKG_CONTENTS} && calculate_rm_modules_dir ${PKG_CONTENTS}
}

pkg_prerm() {
	calculate_rm_modules_dir ${ROOT}/var/db/pkg/${CATEGORY}/${PF}/CONTENTS
}

pkg_postinst() {
	calculate_update_splash ${ROOT}/boot/initramfs-${SYSTEM}-${SLOT}-calculate
	calculate_update_kernel ${SYSTEM} ${SLOT} ${ROOT}/boot
	KV_OUT_DIR=/usr/src/${SRC_NAME}

	kernel-2_pkg_postinst
	UPDATE_MODULEDB=false
	cd $KV_OUT_DIR
	make modules_prepare
	linux-mod_pkg_postinst
}

pkg_postrm() {
	rm -f ${SLOT_T}/.alreadydel
	rmdir ${SLOT_T} &>/dev/null
	calculate_restore_kernel ${ROOT}/boot
}
