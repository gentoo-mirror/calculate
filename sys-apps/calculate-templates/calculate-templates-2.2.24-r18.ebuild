# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}-r9.tar.bz2"

DESCRIPTION="Templates for calculate utilities 2.2"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-lib-2.2.24"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Fix install panel application, fix conf.d/net by flash installation
	# create auxilary dirs, mc colors, sudo su, xmbc,fix kmix crash
	# alsa-utils templates moving, net.eth0 for iso image
	# refix xautologin, fix adblock, remove migrate from firefox to chromium
	# update auto allow for kwallet, fix autologin for installed CLS
	epatch "${FILESDIR}/calculate-templates-2.2.24-r18.patch"
}

src_compile() {
	:
}

src_install() {
	dodir /usr/share/calculate/templates
	insinto /usr/share/calculate/templates
	doins -r *
}
