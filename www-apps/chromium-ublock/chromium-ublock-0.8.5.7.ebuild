# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2
	http://mirror.yandex.ru/calculate/${PN}/${P}.tar.bz2"

DESCRIPTION="uBlock for Chrome"
HOMEPAGE="https://chrome.google.com/webstore/detail/cjpalhdlnbpafiamejdnhcphjbkeiagm"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="www-client/chromium"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dodir /usr/share/chromium-ublock
	insinto /usr/share/chromium-ublock
	doins -r *
}
