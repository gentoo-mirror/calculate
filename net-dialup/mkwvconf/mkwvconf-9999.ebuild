# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit git-2 python
EGIT_REPO_URI="git://github.com/schuay/mkwvconf.git"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Automatically generate a wvdial configuration for mobile broadband devices using mobile-broadband-provider-info"
HOMEPAGE="https://github.com/schuay/mkwvconf"

SLOT="0"
IUSE=""

RDEPEND="net-dialup/wvdial"
DEPEND="${RDEPEND}"

src_install() {
	exeinto /usr/local/bin
	doexe mkwvconf.py
}
