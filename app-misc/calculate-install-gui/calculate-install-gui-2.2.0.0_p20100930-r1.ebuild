# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git

EGIT_COMMIT="b60323add401625b8b4cc9aba8b958a410551fa1"
EGIT_REPO_URI="git://git.calculate.ru/calculate-install-gui.git"

DESCRIPTION="GUI frontend for the program of installation Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="|| ( ~sys-apps/calculate-install-2.2.0.0_p20100921
	~sys-apps/calculate-install-2.2.0.0_p20100930 )
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
