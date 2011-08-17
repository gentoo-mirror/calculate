# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="GUI frontend for the program of installation Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-install-2.2.20
	x11-libs/qtermwidget
	x11-libs/qt-core"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# remove adding "/dev/" for all devices values.
	epatch "${FILESDIR}/calculate-install-gui-2.2.20-r1.patch"
}

src_configure() {
	CMAKE_PREFIX_PATH=/usr  cmake .
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die 'make install failed'
	dodoc README
}
