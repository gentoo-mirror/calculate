# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN=pyasn1-modules
MY_P=$MY_PN-$PV

DESCRIPTION="pyasn1 modules"
HOMEPAGE="http://snmplabs.com/pyasn1/ https://github.com/etingof/pyasn1-modules/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv s390 sparc x86 ~amd64-linux ~x86-linux"

RDEPEND=">=dev-python/pyasn1-python2-0.4.6"
DEPEND="${RDEPEND}"

RESTRICT="test"

S="${WORKDIR}/${MY_PN}-${PV}"

python_install_all() {
	distutils-r1_python_install_all
	rm -r ${D}/usr/share
}
