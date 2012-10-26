# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit calculate

DESCRIPTION="Wallpapers for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/calculate-splash-themes"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="themes_cld themes_cldx themes_cls
themes_cldg themes_cds themes_cmc"

SRC_URI="themes_cld? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cld-13.tar.bz2
)
themes_cldx? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cldx-13.tar.bz2
)
themes_cldg? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cldg-13.tar.bz2
)
themes_cmc? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cmc-13.tar.bz2
)
themes_cds? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cds-13.tar.bz2
)
themes_cls? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cls-13.tar.bz2
)"

REQUIRED_USE="^^ ( themes_cld themes_cldx themes_cls themes_cldg themes_cmc
themes_cds )"

RDEPEND="!media-gfx/cld-themes
!media-gfx/cldg-themes
!media-gfx/cldx-themes
!media-gfx/cls-themes
!media-gfx/cmc-themes
!media-gfx/cds-themes"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}
