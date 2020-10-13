# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN=olefile
MY_P=$MY_PN-$PV
DESCRIPTION="Python package to parse, read and write Microsoft OLE2 files"
HOMEPAGE="https://www.decalage.info/olefile"
SRC_URI="https://github.com/decalage2/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"

RESTRICT="test"

S="${WORKDIR}/${MY_PN}-${PV}"

RDEPEND="
	!dev-python/${MY_PN}[python_targets_python2_7]
"

python_install_all() {
	distutils-r1_python_install_all
	rm -r ${D}/usr/share
}
