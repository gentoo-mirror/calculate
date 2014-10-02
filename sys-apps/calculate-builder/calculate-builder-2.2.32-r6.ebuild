# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2
	http://mirror.yandex.ru/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="Builder tasks utilities for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-lib-2.2.32
	!<sys-apps/calculate-1.4.0_p20100921
	>=app-cdr/cdrtools-3.01_alpha13
	>=sys-boot/grub-2.00-r3
	>=sys-boot/syslinux-4.06
	sys-fs/squashfs-tools"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix variable, remove cl-kernel, fix rescratch
	epatch "${FILESDIR}/calculate-builder-2.2.32-r3.patch"

	# fix clean image
	epatch "${FILESDIR}/calculate-builder-2.2.32-clean.patch"
}
