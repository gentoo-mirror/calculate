# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${P}/${P}.tar.gz"

DESCRIPTION="The package of Python milters that wraps the C libmilter library."
HOMEPAGE="http://spidey2.bmsi.com/pymilter/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="mail-filter/libmilter
		>=dev-lang/python-2.5.2"
RDEPEND="${DEPEND}"
