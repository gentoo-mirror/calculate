# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4-r2

DESCRIPTION="QT4 widget for terminal emulation."
HOMEPAGE="http://qtermwidget.sourceforge.net"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/sources/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.3.4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	qt4-r2_src_prepare
	echo -e "\nCONFIG += ordered" >> qtermwidget.pro
}

src_install() {
	insinto /usr/bin
	doins consoleq
	insinto /usr/lib
	doins libqtermwidget.a
	dodir /usr/include/qtermwidget
	insinto /usr/include/qtermwidget
	doins lib/qtermwidget.h
}
