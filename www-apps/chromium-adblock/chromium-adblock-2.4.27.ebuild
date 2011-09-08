# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

DESCRIPTION="AdBlock for Chrome"
HOMEPAGE="https://chrome.google.com/webstore/detail/gighmmpiobklfepjocnamgkkbiglidom"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="www-client/chromium"

RDEPEND="${DEPEND}"

src_install() {
	dodir /usr/share/chromium-adblock
	insinto /usr/share/chromium-adblock
	doins -r *
}
