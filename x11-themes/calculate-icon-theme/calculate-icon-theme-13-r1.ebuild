# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils

DESCRIPTION="Wallpapers for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/dm-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="themes_CLD themes_CLDX themes_CLS
themes_CLDG"

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/icon/icon-calculate-13-r1.tar.bz2"

REQUIRED_USE="^^ ( themes_CLD themes_CLDX themes_CLDG )"

RDEPEND="themes_CLD? ( kde-base/oxygen-icons )
	themes_CLDG? ( x11-themes/gnome-icon-theme )
	themes_CLDX? ( x11-themes/elementary-icon-theme )
	!media-gfx/cldx-themes
	!media-gfx/cld-themes
	!media-gfx/cldg-themes
	!media-gfx/cls-themes"

DEPEND="${RDEPEND}"

src_install() {
	if use themes_CLD
	then
		sed -ri 's/Inherits=.*/Inherits=oxygen,hicolor/' usr/share/icons/Calculate/index.theme
	fi
	if use themes_CLDG
	then
		sed -ri 's/Inherits=.*/Inherits=gnome,hicolor/' usr/share/icons/Calculate/index.theme
	fi
	if use themes_CLDX
	then
		sed -ri 's/Inherits=.*/Inherits=elementary,hicolor/' usr/share/icons/Calculate/index.theme
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

