# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic multilib toolchain-funcs versionator

MY_PV="${PV/_rc/RC}"

DESCRIPTION="Cyrillic fonts for htmldoc"
HOMEPAGE="http://www.calculate-linux.org/htmldoccyr"
SRC_URI="ftp://ftp.local.calculate.ru/pub/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=app-text/htmldoc-1.8.26"
RDEPEND="${DEPEND}"

src_compile() {
		echo "Nothing compile"
}

src_install() {
		emake install DESTDIR="${D}"
}

pkg_postinst() {
	elog "Execute the following command to replace fonts htmldoc to cyrillic:"
	elog
	elog "/usr/bin/htmldoccyr"
	elog
}
