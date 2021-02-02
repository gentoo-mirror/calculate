# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"
MY_PN=pymilter
MY_P=$MY_PN-$PV

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2

SRC_URI="http://downloads.sourceforge.net/project/${MY_PN}/${MY_PN}/${MY_P}/${MY_P}.tar.gz"

DESCRIPTION="The package of Python milters that wraps the C libmilter library."
HOMEPAGE="http://spidey2.bmsi.com/pymilter/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="
	!dev-python/pymilter[python_targets_python2_7]
	mail-filter/libmilter"
RDEPEND="${DEPEND}
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
"

RESTRICT="test"

S="${WORKDIR}/${MY_PN}-${PV}"

python_install_all() {
	distutils2_python_install_all
	rm -r ${D}/usr/share
}
