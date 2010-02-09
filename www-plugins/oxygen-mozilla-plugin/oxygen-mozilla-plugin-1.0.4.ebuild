# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PLUGIN_UID="{C1F83B1E-D6EE-11DE-B441-1AD556D89593}"
PLUGIN_PN="oxygen_kde"
PLUGIN_BUILD="78486"

DESCRIPTION="Oxygen KDE: plugin for mozilla firefox"
HOMEPAGE="http://addons.mozilla.org/ru/firefox/addon/59338/"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${PLUGIN_PN}-${PV}-fx.xpi"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=">=www-client/mozilla-firefox-3.5.0"

src_unpack() {
	unzip "${DISTDIR}/${A}"
}

src_install() {
	insinto /usr/lib/mozilla-firefox/extensions/${PLUGIN_UID}
	doins -r *
}
