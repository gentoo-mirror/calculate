# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Unofficial GTK 2/3 Breeze Theme"
HOMEPAGE="https://github.com/dirruk1/gnome-breeze"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2
    http://mirror.yandex.ru/calculate/${PN}/${P}.tar.bz2"


LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

src_install() {
	local THEMESDIR="/usr/share/themes/"

	for style in Breeze-dark-gtk Breeze-gtk; do
		dodir ${THEMESDIR}/${style}
		insinto ${THEMESDIR}/${style}
		doins -r ${style}/gtk-2.0 ${style}/gtk-3.0
	done

	dodoc README.md
}
