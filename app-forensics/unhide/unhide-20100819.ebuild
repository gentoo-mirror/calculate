# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Unhide is a forensic tool to find hidden processes and TCP/UDP ports by rootkits/LKMs or by another hidden technique."
HOMEPAGE="http://security-projects.com/?Unhide"
SRC_URI="http://security-projects.com/unhide-20100819.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
    gcc -DVERSION=${PV} ${CFLAGS} -lpthread ${LDFLAGS} \
    ${PN}.c -o ${PN} || die "Failed to compile ${PN}"

    gcc -DVERSION=${PV} ${CFLAGS} -lpthread ${LDFLAGS} \
    ${PN}-linux26.c -o ${PN}-linux26 || die "Failed to compile ${PN}-linux26"

    gcc -DVERSION=${PV} ${CFLAGS} -lpthread ${LDFLAGS} \
    ${PN}-tcp.c -o ${PN}-tcp || die "Failed to compile ${PN}-tcp"
}


src_install() {
    dosbin ${PN} ${PN}-linux26 ${PN}-tcp
    dodoc COPYING README.txt
    doman man/*
}
