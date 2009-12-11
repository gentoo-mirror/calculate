# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
inherit calculate kernel-2 linux-mod

DESCRIPTION="Binary kernel including the Gentoo patchset for the 2.6 kernel tree"
HOMEPAGE="http://www.calculate-linux.org/linux-desktop"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${PN}-`arch`-${PV}.tar.bz2"

GENTOO_SOURCES_PV="2.6.31"
GENTOO_SOURCES_PR="r7"
GENTOO_SOURCES_PVR="${GENTOO_SOURCES_PV}-${GENTOO_SOURCES_PR}"
SRC_NAME=linux-${GENTOO_SOURCES_PV}-gentoo-${GENTOO_SOURCES_PR}
SYSTEM="desktop"

LICENSE="GPL-2"
SLOT="2.6.31"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=sys-kernel/gentoo-sources-${GENTOO_SOURCES_PVR}"
RDEPEND="${DEPEND}"

pkg_setup() {
:
}

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd ${WORKDIR}
}

src_install() {
	dodir /usr/src/${SRC_NAME}
	insinto /
	doins -r boot
	doins -r lib
	
	dosym /usr/src/${SRC_NAME} "/lib/modules/${GENTOO_SOURCES_PV}-calculate/source" || die "cannot install source symlink"
	dosym /usr/src/${SRC_NAME} "/lib/modules/${GENTOO_SOURCES_PV}-calculate/build" || die "cannot install build symlink"

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
}

pkg_postinst() {
	calculate_update_splash /boot/initramfs-${SYSTEM}-${SLOT}-calculate
	calculate_update_kernel ${SYSTEM} ${SLOT} /boot

	kernel-2_pkg_postinst
	linux-mod_pkg_postinst
}

