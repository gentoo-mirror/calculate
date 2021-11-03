# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=7

DESCRIPTION="tool to test and create graphical boot logos"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/gfxboot/${PV}-1/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="x86 amd64"

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

PATCHES=(
	"${FILESDIR}/gfxboot-fix_warning.patch"
	"${FILESDIR}/gfxboot-fix_bigsize.patch"
)

src_install() {
	emake DESTDIR="${D}" THEMES="" install || die
}
