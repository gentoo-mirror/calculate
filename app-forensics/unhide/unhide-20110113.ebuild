# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Unhide is a forensic tool to find hidden processes and TCP/UDP ports by rootkits/LKMs"
HOMEPAGE="http://security-projects.com/?Unhide"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	append-cflags -lpthread
}

src_compile() {
	$(tc-getCC) -DVERSION=${PV} ${CFLAGS} ${LDFLAGS} \
	${PN}.c -o ${PN} || die "Failed to compile ${PN}"

	$(tc-getCC) -DVERSION=${PV} ${CFLAGS} ${LDFLAGS} \
	${PN}-linux26.c -o ${PN}-linux26 || die "Failed to compile ${PN}-linux26"

	$(tc-getCC) -DVERSION=${PV} ${CFLAGS} ${LDFLAGS} \
	${PN}-tcp.c -o ${PN}-tcp || die "Failed to compile ${PN}-tcp"
}

src_install() {
	dosbin ${PN} ${PN}-linux26 ${PN}-tcp
	dodoc README.txt
	doman man/*
}
