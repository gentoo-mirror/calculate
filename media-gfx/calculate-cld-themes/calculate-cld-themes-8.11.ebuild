# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Themes for CLD"
HOMEPAGE="http://www.calculate-linux.ru/calcualte-cld-themes"
SRC_URI="ftp://ftp.local.calculate.ru/pub/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
		insinto /
		doins -r .
}
