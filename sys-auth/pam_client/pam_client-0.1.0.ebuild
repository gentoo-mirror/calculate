# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Module of the waiting client daemon"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	make CFLAGS="-Wall ${CFLAGS}" || die
}

src_install() {
	emake install DESTDIR="${D}"
}
