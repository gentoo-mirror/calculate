# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit kde4-base eutils

DESCRIPTION="Translator using google translator"
HOMEPAGE="http://kde-look.org/content/show.php/translatoid?content=97511"
SRC_URI="http://ktank.free.fr/plasmoid/${PN}.0.9.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="
	>=kde-base/kdelibs-4.2.0
	>=dev-util/cmake-2.4"

S="${WORKDIR}/${PN}"

PATCHES=("${FILESDIR}/paste-${PV}.patch")
