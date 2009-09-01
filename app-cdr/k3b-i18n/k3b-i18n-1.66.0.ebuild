# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit kde4-base eutils

DESCRIPTION="K3b internationalization package"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${PF}.tar.bz2"
HOMEPAGE="http://www.k3b.org/"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS="~x86 ~amd64"

IUSE=""
LANGS="ru uk fr de pt_BR es pl it"

DEPEND="app-cdr/k3b:4"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# deleting compiling of unnecessary translation
	for LG in $LANGS;do
		if ! has $LG ${LINGUAS};
		then
			sed -i "/($LG)/d" CMakeLists.txt
		fi
	done
}

src_configure() {
	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst
}
