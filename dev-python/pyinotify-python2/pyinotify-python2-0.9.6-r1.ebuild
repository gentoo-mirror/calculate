# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils-r1

MY_PN=pyinotify
MY_P=$MY_PN-$PV

DESCRIPTION="Python module used for monitoring filesystems events"
HOMEPAGE="
	http://trac.dbzteam.org/pyinotify
	https://pypi.org/project/pyinotify/
	https://github.com/seb-m/pyinotify/"
SRC_URI="http://seb.dbzteam.org/pub/pyinotify/releases/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~mips ppc ppc64 ~riscv s390 sparc x86 ~amd64-linux ~x86-linux"

RESTRICT="test"

RDEPEND="
	!dev-python/${MY_PN}[python_targets_python2_7]
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_PN}-${PV}"

python_install_all() {
	distutils-r1_python_install_all
	rm -r ${D}/usr/share
}
