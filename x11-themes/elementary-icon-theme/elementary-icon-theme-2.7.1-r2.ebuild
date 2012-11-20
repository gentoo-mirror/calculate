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
	dosym applications-games.svg $ICON_PATH/applications-cardgames.svg
	dosym preferences-desktop-peripherals.svg $ICON_PATH/applications-electronics.svg
	dosym preferences-desktop-personal.svg $ICON_PATH/applications-profiling.svg
	dosym preferences-desktop-screensaver.svg $ICON_PATH/applications-viewers.svg

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

