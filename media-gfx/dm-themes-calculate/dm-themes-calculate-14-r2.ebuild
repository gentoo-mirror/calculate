# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Wallpapers for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/dm-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/dm/dm-14-r4.tar.bz2"

RDEPEND=""

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}

