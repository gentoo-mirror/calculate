# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git kde4-base

DESCRIPTION="A Qt wrapper for bluez used in the KDE bluetooth stack"
HOMEPAGE="http://gitorious.org/libbluedevil"
EGIT_COMMIT="d8ca7aba3e24844bbb3ad3b5c8c334471f24ee59"
EGIT_REPO_URI="git://gitorious.org/libbluedevil/libbluedevil.git"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	net-wireless/bluez
"

src_unpack() {
	git_src_unpack
}
