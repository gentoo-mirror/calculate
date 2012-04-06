# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"

inherit calculate-kernel-3 eutils

DESCRIPTION="Full sources including the Calculate patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
KEYWORDS="amd64 x86"
HOMEPAGE="http://www.calculate-linux.org"

IUSE=""
#IUSE="hardened"

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-5"
#HGPV_URI="hardened? (
#http://dev.gentoo.org/~blueness/hardened-sources/hardened-patches/hardened-patches-${HGPV}.extras.tar.bz2
#)"
HGPV_URI=""

CL_PATCH="3.2.5"

CALC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${PN}-${CL_PATCH}.tar.bz2
        ftp://ftp.calculate-linux.org/pub/calculate/${PN}/${PN}-${CL_PATCH}.tar.bz2
		http://mirror.yandex.ru/calculate/${PN}/${PN}-${CL_PATCH}.tar.bz2
		ftp://ftp.linux.kiev.ua/pub/Linux/Calculate/${PN}/${PN}-${CL_PATCH}.tar.bz2"

SRC_URI="${KERNEL_URI} ${ARCH_URI} ${CALC_URI} ${HGPV_URI}"

UNIPATCH_LIST="${DISTDIR}/${PN}-${CL_PATCH}.tar.bz2"

DEPEND="vmlinuz? ( >=sys-kernel/calckernel-3.4.18
	>=sys-apps/calculate-builder-2.2.22-r2
	|| ( app-arch/xz-utils app-arch/lzma-utils )
	sys-apps/v86d
	!<net-wireless/rtl8192se-3.0
	sys-boot/grub
	)"

CL_KERNEL_OPTS="--lvm --mdadm --dmraid"

src_unpack() {
	if use hardened; then
		UNIPATCH_LIST+=" ${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
		UNIPATCH_EXCLUDE="4400_aufs2.patch"
	fi
	calculate-kernel-3_src_unpack
}

pkg_postinst() {
	calculate-kernel-3_pkg_postinst
}
