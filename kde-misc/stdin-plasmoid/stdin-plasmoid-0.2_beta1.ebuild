# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde eutils

MY_P="0.2-beta1"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Plasmoid executes a process and captures its stdout output stream"
HOMEPAGE="http://kde-look.org/content/show.php/STDIN+Plasmoid?content=92309"
SRC_URI="http://kde-look.org/CONTENT/content-files/92309-0.2-beta1.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="
	>=kde-base/kdelibs-4.2.0
	>=dev-util/cmake-2.4"

src_compile() {
	epatch "${FILESDIR}/color.patch"
	cmake -DCMAKE_INSTALL_PREFIX=/usr/ || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
