# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#PLUGIN_UID="{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
PLUGIN_UID="xclear@as-computer.de"
PLUGIN_PN="addon"
PLUGIN_BUILD="13078"

DESCRIPTION="Xclear: plugin for mozilla firefox"
HOMEPAGE="http://addons.mozilla.org/ru/firefox/addon/13078"
SRC_URI="http://addons.mozilla.org/downloads/latest/${PLUGIN_BUILD}/${PLUGIN_PN}-${PV}-latest.xpi
	     ftp://ftp.calculate.ru/pub/calculate/${PN}/${PLUGIN_PN}-${PV}-latest.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="www-client/firefox"

src_unpack() {
	unzip "${DISTDIR}/${A}"
}

src_install() {
	insinto /usr/lib/mozilla-firefox/extensions/${PLUGIN_UID}
	doins -r *
}
