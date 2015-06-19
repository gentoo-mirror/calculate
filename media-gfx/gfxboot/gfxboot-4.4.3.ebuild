# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=2

inherit eutils

DESCRIPTION="tool to test and create graphical boot logos"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI="mirror://ubuntu/pool/main/g/gfxboot/gfxboot_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="app-arch/cpio
	dev-lang/nasm
	>=media-libs/freetype-2
	app-text/xmlto
	dev-libs/libxslt
	app-text/docbook-xml-dtd:4.1.2
	dev-perl/HTML-Parser"
RDEPEND="${DEPEND}"
RESTRICT="mirror"

src_prepare() {
	epatch "${FILESDIR}/gfxboot-fix_warning.patch"
	epatch "${FILESDIR}/gfxboot-fix_freetype.patch"
}

src_install() {
	emake DESTDIR="${D}" THEMES="" install || die
}
