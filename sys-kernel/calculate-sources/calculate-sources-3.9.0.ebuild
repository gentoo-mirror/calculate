# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
ETYPE="sources"

inherit calculate-kernel-5 eutils

DESCRIPTION="Calculate Linux kernel image"
KEYWORDS=""
HOMEPAGE="http://www.calculate-linux.org"

IUSE=""
#IUSE="hardened"

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-5"
HGPV_URI=""

SRC_URI="${KERNEL_URI} ${ARCH_URI} ${HGPV_URI}"

DEPEND="vmlinuz? ( >=sys-kernel/calckernel-3.4.18-r12
	>=sys-apps/calculate-builder-2.2.30-r3
	>=sys-apps/calculate-core-3.1.4_beta1-r1
	>=sys-apps/calculate-install-3.1.4_beta1
	|| ( app-arch/xz-utils app-arch/lzma-utils )
	sys-apps/v86d
	!<net-wireless/rtl8192se-3.0
	sys-boot/grub
	)"

CL_KERNEL_OPTS="--lvm --mdadm --dmraid"

src_unpack() {
	calculate-kernel-5_src_unpack
}

pkg_postinst() {
	calculate-kernel-5_pkg_postinst
}
