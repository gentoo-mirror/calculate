# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils-r1

MY_PN=typing
MY_P=$MY_PN-$PV
DESCRIPTION="Type Hints for Python"
HOMEPAGE="https://docs.python.org/3/library/typing.html https://pypi.org/project/typing/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~mips ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux ~x64-solaris"
IUSE=""
RESTRICT="test"

DEPEND="dev-python/setuptools-python2[${PYTHON_USEDEP}]"
RDEPEND="!dev-python/${MY_PN}[python_targets_python2_7]"

S="${WORKDIR}/${MY_PN}-${PV}"

python_install_all() {
	distutils-r1_python_install_all
	rm -r ${D}/usr/share
}
