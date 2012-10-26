# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Wallpapers for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/calcualte-cld-themes"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/calculate-wallpapers"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="themes_cld themes_cldx themes_cls
themes_cldg"

SRC_URI="themes_cld? (
	ftp://ftp.calculate.ru/pub/calculate/themes/wallpapers/wallpapers-cld-13.tar.bz2
)
themes_cldx? (
	ftp://ftp.calculate.ru/pub/calculate/themes/wallpapers/wallpapers-cldx-13.tar.bz2
)
themes_cldg? (
	ftp://ftp.calculate.ru/pub/calculate/themes/wallpapers/wallpapers-cldg-13.tar.bz2
)
themes_cls? (
	ftp://ftp.calculate.ru/pub/calculate/themes/wallpapers/wallpapers-cls-13.tar.bz2
)"

REQUIRED_USE="^^ ( themes_cld themes_cldx themes_cls themes_cldg )"

RDEPEND="!media-gfx/calculate-cldx-themes
		!media-gfx/calculate-cld-themes
		!media-gfx/cldx-themes"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}

