# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PLUGIN_UID="{d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d}"
PLUGIN_PN="adblock_plus"
PLUGIN_BUILD="1865"

DESCRIPTION="Adblock Plus: plugin for mozilla firefox"
HOMEPAGE="http://adblockplus.org/en/"
SRC_URI="http://addons.mozilla.org/downloads/latest/${PLUGIN_BUILD}/${PLUGIN_PN}-${PV}.xpi"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
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
