# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2

MY_PN=faulthandler
MY_P=$MY_PN-$PV
DESCRIPTION="functions to dump Python tracebacks explicitly (on fault, user signal, timeout)"
HOMEPAGE="https://github.com/haypo/faulthandler https://pypi.org/project/faulthandler/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
RESTRICT="test"

DEPEND="dev-python/setuptools-python2[${PYTHON_USEDEP}]"
RDEPEND="
	!dev-python/${MY_PN}[python_targets_python2_7]
"

S="${WORKDIR}/${MY_PN}-${PV}"

python_install_all() {
	distutils2_python_install_all
	rm -r ${D}/usr/share
}
