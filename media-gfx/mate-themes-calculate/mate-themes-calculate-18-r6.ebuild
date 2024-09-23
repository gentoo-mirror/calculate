# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Mate theme for Calculate Linux"
HOMEPAGE="https://www.calculate-linux.org/packages/media-gfx/mate-themes-calculate"
SRC_URI="https://mirror.calculate-linux.org/themes/mate/${PF}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

src_install() {
	insinto /
	doins -r .
}
