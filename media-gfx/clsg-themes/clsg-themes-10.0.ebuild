# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The theme for Calculate Linux Scratch GNOME"
HOMEPAGE="http://www.calculate-linux.org/calcualte-clsg-themes"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="!media-gfx/clsg-themes"

DEPEND="${RDEPEND}"

src_install() {
		insinto /
		doins -r .
}
