# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1
MY_PN=pyasn1
MY_P=$MY_PN-$PV

DESCRIPTION="ASN.1 library for Python"
HOMEPAGE="http://snmplabs.com/pyasn1/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"

RESTRICT="test"

S="${WORKDIR}/${MY_PN}-${PV}"

python_install_all() {
	distutils-r1_python_install_all
	rm -r ${D}/usr/share
}
