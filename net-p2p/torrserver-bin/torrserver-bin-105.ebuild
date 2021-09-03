# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="TorrServer, stream torrent to http"
HOMEPAGE="https://github.com/YouROK/TorrServer"
SRC_URI="
	amd64? ( https://github.com/YouROK/TorrServer/releases/download/MatriX.${PV}/TorrServer-linux-amd64 -> TorrServer-linux-amd64-${PV} )
"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"
RESTRICT="strip"

RDEPEND="
	acct-user/torrserver
"

QA_PREBUILT="*"

S="${WORKDIR}"

src_unpack() {
	cp -v ${DISTDIR}/${A} ${S}
}

src_install() {
	dodir /opt/torrserver
	cp "${S}"/TorrServer-linux-amd64-${PV} "${ED}"/opt/torrserver/TorrServer-linux-amd64 || die
	fperms 0755 /opt/torrserver/TorrServer-linux-amd64
	newinitd "${FILESDIR}"/torrserver.initd torrserver
	doenvd "${FILESDIR}"/99torrserver
}
