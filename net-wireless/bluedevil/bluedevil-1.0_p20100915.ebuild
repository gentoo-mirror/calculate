# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git kde4-base

DESCRIPTION="Bluetooth stack for KDE"
HOMEPAGE="http://gitorious.org/bluedevil"
EGIT_COMMIT="4d13976637b5063198ff834b51a386c4aa9710a5"
EGIT_REPO_URI="git://gitorious.org/bluedevil/bluedevil.git"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	~net-libs/libbluedevil-1.9_p20100915
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	!net-wireless/kbluetooth
	app-mobilephone/obexd
	app-mobilephone/obex-data-server
"

src_unpack() {
	git_src_unpack
}
