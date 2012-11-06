# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="The collection of Russian-English dictionaries"
HOMEPAGE="http://www.calculate-linux.org/packages/app-dicts/stardict-calculate-ru"

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

KEYWORDS="amd64 x86"
IUSE=""
SLOT="0"

RDEPEND="!media-gfx/cld-themes
!media-gfx/cldg-themes
!media-gfx/cldx-themes
!media-gfx/cls-themes"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}
