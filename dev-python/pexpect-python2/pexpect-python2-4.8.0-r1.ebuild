# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils-r1

MY_PN=pexpect
MY_P=$MY_PN-$PV

DESCRIPTION="Python module for spawning child apps and responding to expected patterns"
HOMEPAGE="https://pexpect.readthedocs.io/ https://pypi.org/project/pexpect/ https://github.com/pexpect/pexpect/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="examples"
RESTRICT="test"

RDEPEND="
	!dev-python/pexpect[python_targets_python2_7]
	>=dev-python/ptyprocess-python2-0.5[${PYTHON_USEDEP}]"
DEPEND="
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
"
S="${WORKDIR}/${MY_PN}-${PV}"

python_install() {
	distutils-r1_python_install
	rm "${D}$(python_get_sitedir)/pexpect/_async.py" || die
}

python_install_all() {
	distutils-r1_python_install_all
	rm -r ${D}/usr/share
}
