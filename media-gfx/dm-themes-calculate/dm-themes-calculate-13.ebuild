# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Wallpapers for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/dm-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="themes_CLD themes_CLDX themes_CLS
themes_CLDG"

SRC_URI="themes_CLD? (
	ftp://ftp.calculate.ru/pub/calculate/themes/dm/dm-cld-13.tar.bz2
)
themes_CLDX? (
	ftp://ftp.calculate.ru/pub/calculate/themes/dm/dm-cldx-13.tar.bz2
)
themes_CLDG? (
	ftp://ftp.calculate.ru/pub/calculate/themes/dm/dm-cldg-13.tar.bz2
)
themes_CLS? (
	ftp://ftp.calculate.ru/pub/calculate/themes/dm/dm-cls-13.tar.bz2
)"

REQUIRED_USE="^^ ( themes_CLD themes_CLDX themes_CLS themes_CLDG )"

RDEPEND=""

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}

