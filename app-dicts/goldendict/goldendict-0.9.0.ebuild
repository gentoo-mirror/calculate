# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt4 eutils

DESCRIPTION="Feature-rich dictionary lookup program"
HOMEPAGE="http://goldendict.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}-src-x11.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="${RDEPEND}
	>=x11-libs/qt-core-4.5
	>=x11-libs/qt-gui-4.5
	>=x11-libs/qt-webkit-4.5
	=app-text/hunspell-1.2*
	x11-libs/libXtst"
RDEPEND="dev-libs/libzip
	media-libs/libvorbis
	sys-libs/zlib"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	# useless stuff
	sed -i \
		-e s/INSTALLS\ \+=\ desktops2//g \
		-e s/INSTALLS\ \+=\ icons2//g \
		"${S}"/goldendict.pro || die "sed failed"
}

src_compile() {
	if use nls; then
		lrelease goldendict.pro || die "lrelease failed"
	fi
	PREFIX=/usr eqmake4 || die "eqmake failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake failed"
}
