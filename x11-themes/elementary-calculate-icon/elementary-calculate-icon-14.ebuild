# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils

DESCRIPTION="Calculate fork of elementary icon theme."
HOMEPAGE="http://www.calculate-linux.org/"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/elementary/elementary-calculate-icon-14.tar.bz2
		http://mirror.yandex.ru/calculate/themes/elementary/elementary-calculate-icon-14.tar.bz2"

RESTRICT="binchecks strip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
		x11-themes/hicolor-icon-theme"

src_install() {
	insinto /usr/share/icons
	doins -r elementary-calculate
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
