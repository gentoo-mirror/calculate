# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/claws-mail-themes/claws-mail-themes-20120129.ebuild,v 1.2 2012/05/20 09:46:48 fauli Exp $

EAPI=6
DESCRIPTION="Iconset Papirus for Claws Mail"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-claws-mail-theme"
COMMIT="7d02981d23ecfc279c87ff6c172ba09314940352"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="mail-client/claws-mail"
DEPEND=""
S="${WORKDIR}/papirus-claws-mail-theme-${COMMIT}"

src_install() {
	insinto /usr/share/claws-mail/themes
	doins -r Papirus
}
