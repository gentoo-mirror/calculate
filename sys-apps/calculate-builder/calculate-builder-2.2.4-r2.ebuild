# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The utilities for builder tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-install-2.2.4
	>=sys-apps/calculate-templates-2.2.4-r3
	<sys-apps/calculate-templates-2.2.5
	!<sys-apps/calculate-1.4.0_p20100921
	app-cdr/cdrkit
	sys-fs/squashfs-tools"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# disable splash for initramfs
	epatch "${FILESDIR}/calculate-builder-2.2.4-disable_splash.patch"
}
