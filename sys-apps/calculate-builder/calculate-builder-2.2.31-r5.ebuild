# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The utilities for builder tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=">=sys-kernel/calckernel-3.4.18
	~sys-apps/calculate-lib-2.2.31
	!<sys-apps/calculate-1.4.0_p20100921
	>=app-cdr/cdrtools-3.01_alpha13
	>=sys-boot/grub-2.00-r3
	>=sys-boot/syslinux-4.06
	sys-fs/squashfs-tools"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# remove depricated templates,UEFI hybrid
	epatch "${FILESDIR}/calculate-builder-2.2.31-r4.patch"
	# fix version of calculate builder to 2.2.32 for using iso grub templates
	epatch "${FILESDIR}/calculate-builder-2.2.31-fix_version.patch"
}
