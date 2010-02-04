# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PLUGIN_UID="plasmanotify@andreas-demmer.de"
PLUGIN_PN="addon"
PLUGIN_BUILD="12196"

DESCRIPTION="Plasma Notify: plugin for mozilla firefox"
HOMEPAGE="http://www.andreas-demmer.de/software/plasma-notify/"
SRC_URI="http://addons.mozilla.org/downloads/latest/${PLUGIN_BUILD}/${PLUGIN_PN}-${PV}-latest.xpi
	     ftp://ftp.calculate.ru/pub/calculate/${PN}/${PLUGIN_PN}-${PV}-latest.xpi"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="www-client/mozilla-firefox"

src_unpack() {
	unzip "${DISTDIR}/${A}"
}

src_install() {
	insinto /usr/lib/mozilla-firefox/extensions/${PLUGIN_UID}
	doins -r *
}
