# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="ioping is a simple disk I/O latency monitoring tool"
HOMEPAGE="http://kir.sacred.ru/ioping/ http://code.google.com/p/ioping/"
SRC_URI="http://ioping.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	mv Makefile Makefile.orig
	sed -e "s/PREFIX=\/usr\/local/PREFIX=\/usr/" Makefile.orig > Makefile
	emake || die
}

src_install() {
    dobin ${PN}
    doman ${PN}.1
}
