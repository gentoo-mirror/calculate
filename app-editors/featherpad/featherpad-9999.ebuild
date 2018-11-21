# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils git-r3

MY_P="${P/featherpad/FeatherPad}"

DESCRIPTION="Lightweight Qt5 Plain-Text Editor for Linux"
HOMEPAGE="https://github.com/tsujan/FeatherPad"
EGIT_REPO_URI="https://github.com/tsujan/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

S="${WORKDIR}/${MY_P}"

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
}
