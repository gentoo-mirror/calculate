# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Skdet is a simple program that will detect the rootkits"
HOMEPAGE="http://www.xs4all.nl/~dvgevers/skdet/"
SRC_URI="http://www.xs4all.nl/~dvgevers/skdet/skdet-1.0.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	rm "${PN}"
	emake ||die
}

src_install() {
	dosbin "${PN}"
	dodoc AUTHORS  ChangeLog  CONTRIBUTIONS
	doman "${FILESDIR}"/"${PN}".1
}
