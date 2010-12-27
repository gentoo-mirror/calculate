# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The program of installation Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="minimal"

DEPEND="~sys-apps/calculate-lib-2.2.4
	app-portage/layman
	!minimal? ( sys-boot/grub
	sys-fs/dosfstools
	sys-fs/squashfs-tools
	sys-block/parted )"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix read options from fstab with UUID
	epatch "${FILESDIR}/calculate-install-2.2.4-fix_fstab.patch"
	# fix fill method install_linux_ver
	epatch "${FILESDIR}/calculate-install-2.2.4-fix_linux_ver.patch"
}

pkg_postinst() {
	einfo "For configure calculate-install perform:"
	einfo "  cl-install --install"
}
