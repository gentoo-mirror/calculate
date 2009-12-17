# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base eutils

DESCRIPTION="Translator using google translator"
HOMEPAGE="http://kde-look.org/content/show.php/translatoid?content=97511"
SRC_URI="http://thecorpo.fr/sacha/${PN}/${PN}1-1.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/kdelibs-4.3.0
	>=dev-libs/qjson-0.6.3
	>=dev-util/cmake-2.4"

S="${WORKDIR}/${PN}-1.1"

PATCHES=("${FILESDIR}/compilefix-1.1.0.patch")
