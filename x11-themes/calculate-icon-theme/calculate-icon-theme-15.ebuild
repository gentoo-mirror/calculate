# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils

DESCRIPTION="Icons theme for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/x11-themes/calculate-icon-theme"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="kde"

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/icon/icon-calculate-15.tar.bz2
	http://mirror.yandex.ru/calculate/themes/icon/icon-calculate-15.tar.bz2"

RDEPEND="kde? ( kde-apps/oxygen-icons )
	!kde? ( || ( x11-themes/elementary-icon-theme
		x11-themes/gnome-icon-theme
		x11-themes/mate-icon-theme )
	)"

DEPEND="${RDEPEND}"

src_install() {
	if use kde
	then
		rm -r usr/share/pixmaps/gnome
		mv  usr/share/pixmaps/oxygen usr/share/pixmaps/faces
	else
		rm -r usr/share/pixmaps/oxygen
		mv  usr/share/pixmaps/gnome usr/share/pixmaps/faces
	fi
	insinto /
	doins -r .
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

