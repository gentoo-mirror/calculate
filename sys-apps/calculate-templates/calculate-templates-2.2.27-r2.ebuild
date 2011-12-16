# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="Templates for calculate utilities 2.2"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-lib-2.2.27"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# nvidia-blacklist
	epatch "${FILESDIR}/calculate-templates-2.2.27-r2.patch"
}

src_compile() {
	:
}

src_install() {
	dodir /usr/share/calculate/templates
	insinto /usr/share/calculate/templates
	doins -r *
}
