# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils

DESCRIPTION="Elementary icon theme is designed to be smooth, sexy, clear, and efficient"
HOMEPAGE="https://launchpad.net/elementaryicons"
SRC_URI="http://launchpad.net/elementaryicons/2.0/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="monochrome"

ICON_PATH="/usr/share/icons/elementary/categories/48"

CDEPEND=""
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	x11-libs/gtk+:2"

RESTRICT="binchecks strip"

pkg_setup() {
	DOCS="elementary/AUTHORS elementary/COPYING elementary/CONTRIBUTORS"
	S="${WORKDIR}/${PN}"
}

src_install() {
	dodoc ${DOCS}
	rm ${DOCS}

	rm -r elementary/status/48/untitled\ folder
	
	dosym applications-other.svg $ICON_PATH/applications-office.svg
	dosym applications-painting.svg $ICON_PATH/applications-graphics.svg
	dosym applications-utilities.svg $ICON_PATH/applications-accessories.svg
	dosym applications-cardgames.svg $ICON_PATH/applications-games.svg
	dosym applications-electronics.svg $ICON_PATH/preferences-desktop-peripherals.svg
	dosym applications-profiling.svg $ICON_PATH/preferences-desktop-personal.svg
	dosym applications-viewers.svg $ICON_PATH/preferences-desktop-screensaver.svg

	insinto /usr/share/icons
	doins -r elementary
	use monochrome && doins -r elementary-mono-dark
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

