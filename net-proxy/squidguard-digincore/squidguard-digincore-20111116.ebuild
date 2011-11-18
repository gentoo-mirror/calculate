# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="18+ blacklists for SquidGuard"
HOMEPAGE="http://www.digincore.org/"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/squidguard-digincore/${P}.tar.bz2"

LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="net-proxy/squidguard"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
}

src_compile() {
	:
}

src_install() {
	dodir /var/lib/squidguard
	insinto /var/lib/squidguard
	doins -r *
}

pkg_postinst() {
	chown -R squid:squid /var/lib/squidguard/
	einfo "To use this blacklist in /etc/squidGuard/squidGuard.conf"
	einfo "you must have this lines:"
	echo
	einfo "dbhome /var/lib/squidguard/"
	echo
	einfo "dest digincore{"
	einfo "    domainlist digincore-general/domains"
	einfo "}"
	echo
	einfo "And acl settings like this:"
	echo
	einfo "acl {"
	einfo "    default {"
	einfo "        pass !digincore all"
	einfo "        redirect http://localhost/block.html"
	einfo "    }"
	einfo "}"
	echo
	echo
	einfo "After editing config you must exec this commands:"
	echo
	einfo "squidGuard -C all"
	einfo "chown -R squid:squid /var/lib/squidguard/"
	einfo "/etc/init.d/squid reload"
	echo
}
