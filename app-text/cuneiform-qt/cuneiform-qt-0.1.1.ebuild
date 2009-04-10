# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/wpa_supplicant-0.6.4.ebuild,v 1.4 2009/02/01 21:23:45 maekke Exp $

inherit eutils

EAPI="1"

DESCRIPTION="Graphical interface to Cuneiform"
HOMEPAGE="http://www.altlinux.org/Cuneiform-Qt"
SRC_URI="ftp://ftp.local.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2
         ftp://mirror.yandex.ru/calculate/${PN}/${P}.tar.bz2
         http://mirror.yandex.ru/calculate/${PN}/${P}.tar.bz2
		 ftp://ftp.linux.kiev.ua/pub/Linux/Calculate/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-text/cuneiform-0.6
		x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/lang.patch"
}

src_compile() {
	PREFIX="/usr" qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	einstall INSTALL_ROOT="${D}" || die "install failed"
}

