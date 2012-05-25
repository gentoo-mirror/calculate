# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3/${PN}/${P}.tar.bz2"

DESCRIPTION="The program of installation Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

DEPEND="~sys-apps/calculate-lib-3.0.0_alpha4
	app-portage/layman
	!app-misc/livecd-tools
	sys-apps/iproute2[-minimal]
	!minimal? ( sys-boot/grub
	sys-apps/gptfdisk
	>=sys-apps/util-linux-2.19.1
	sys-fs/dosfstools
	sys-fs/squashfs-tools
	sys-block/parted )"

RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo "For install wsdl for calculate-install perform:"
	einfo "  cl-core --write-variable cl_wsdl=calculate-install"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix SSD device detect
	epatch "${FILESDIR}/calculate-install-3.0.0_alpha4-r1.patch"
	# hide cl-install3
	epatch "${FILESDIR}/calculate-install-3.0.0_alpha4-fixsetup.patch"
}
