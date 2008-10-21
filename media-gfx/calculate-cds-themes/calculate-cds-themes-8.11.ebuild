# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Theme for CDS"
HOMEPAGE="http://www.calculate-linux.ru/calcualte-cds-themes"
SRC_URI="ftp://ftp.local.calculate.ru/pub/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
		insinto /
		doins -r .
}
