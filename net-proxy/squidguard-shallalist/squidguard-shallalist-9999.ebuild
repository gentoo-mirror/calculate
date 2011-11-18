# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Blacklists for SquidGuard"
HOMEPAGE="http://www.shallalist.de/"

LICENSE="Shalla's Blacklists - Licence"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="net-proxy/squidguard"
RDEPEND="${DEPEND}"

TARFILE="shallalist.tar.gz"

src_unpack() {
	wget "http://www.shallalist.de/Downloads/${TARFILE}" -O "${DISTDIR}/${TARFILE}"
	tar -xzf "${DISTDIR}/${TARFILE}" -C "${WORKDIR}/"
}

src_compile() {
	:
}

src_install() {
	dodir /var/lib/squidguard
	dodir /var/lib/squidguard/BL
	insinto /var/lib/squidguard/BL
	doins -r BL/*
}

pkg_postinst() {
	chown -R squid:squid /var/lib/squidguard/
	einfo "To use this blacklists in /etc/squidGuard/squidGuard.conf"
	einfo "you must have this line:"
	echo
	einfo "dbhome /var/lib/squidguard/"
	echo
	einfo "To enable some list in SquidGuard you can add section like this:"
	echo
	einfo "dest adv{"
	einfo "    domainlist BL/adv/domains"
	einfo "    urllist BL/adv/urls"
	einfo "    redirect http://localhost/block.html"
	einfo "}"
	echo
	einfo "And acl settings like this:"
	echo
	einfo "acl {"
	einfo "    default {"
	einfo "        pass !adv all"
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
