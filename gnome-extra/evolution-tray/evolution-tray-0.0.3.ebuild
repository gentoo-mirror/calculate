# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The plugin for placing evolution in notification area."
HOMEPAGE="http://gnome.eu.org/evo/index.php/Evolution_Tray"
SRC_URI="http://gnome.eu.org/evolution-tray-0.0.3.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="mail-client/evolution"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc NEWS README* AUTHORS ChangeLog || die "dodoc failed"
}
