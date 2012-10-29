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
IUSE="themes_CLD themes_CLDX themes_CLS
themes_CLDG themes_CDS themes_CMC"

SRC_URI="themes_CLD? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cld-13.tar.bz2
)
themes_CLDX? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cldx-13.tar.bz2
)
themes_CLDG? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cldg-13.tar.bz2
)
themes_CMC? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cmc-13.tar.bz2
)
themes_CDS? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cds-13.tar.bz2
)
themes_CLS? (
	ftp://ftp.calculate.ru/pub/calculate/themes/splash/splash-cls-13.tar.bz2
)"

REQUIRED_USE="^^ ( themes_CLD themes_CLDX themes_CLS themes_CLDG themes_CMC
themes_CDS )"

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
