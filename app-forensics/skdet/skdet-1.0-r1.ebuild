# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Skdet is a simple program that will detect the rootkits"
HOMEPAGE="http://www.xs4all.nl/~dvgevers/skdet/"
SRC_URI="http://dvgevers.home.xs4all.nl/skdet/skdet-1.0.tar.bz2
	http://dvgevers.home.xs4all.nl/skdet/skdet-1.0.1
	http://dvgevers.home.xs4all.nl/skdet/skdet-fix-includes.diff"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${DISTDIR}"/"${PN}"-fix-includes.diff )

src_prepare() {
	base_src_prepare
	rm "${PN}"
	sed -e '/STRIP/d' -i "${S}"/Makefile || die "sed failed"
}

src_install() {
	dodoc AUTHORS ChangeLog CONTRIBUTIONS CREDITS README tests/*
	dosbin "${PN}"
	doman "${DISTDIR}"/"${P}".1
}
