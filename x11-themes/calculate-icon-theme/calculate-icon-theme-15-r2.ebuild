# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils

DESCRIPTION="Icons theme for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/x11-themes/calculate-icon-theme"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/icon/icon-calculate-15-r2.tar.bz2
	http://mirror.yandex.ru/calculate/themes/icon/icon-calculate-15-r2.tar.bz2"

REQUIRED_USE=""

RDEPEND="|| ( 
		kde-plasma/breeze
		kde-apps/oxygen-icons
		x11-themes/elementary-icon-theme
		x11-themes/gnome-icon-theme
		x11-themes/mate-icon-theme
	)"

DEPEND="${RDEPEND}"

src_install() {
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

