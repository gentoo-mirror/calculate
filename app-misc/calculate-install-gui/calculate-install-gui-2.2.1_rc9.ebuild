# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git

EGIT_COMMIT="5599dc390139155dce44e048c4adfea32d8383d2"
EGIT_REPO_URI="git://git.calculate.ru/calculate-install-gui.git"

DESCRIPTION="GUI frontend for the program of installation Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="~sys-apps/calculate-install-2.2.1_rc9
	x11-libs/qtermwidget"

RDEPEND="${DEPEND}"

src_configure() {
	CMAKE_PREFIX_PATH=/usr  cmake .
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die 'make install failed'
	dodoc README
}
