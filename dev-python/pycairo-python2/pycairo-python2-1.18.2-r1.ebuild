# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils-r1

MY_PN=pycairo
MY_P=$MY_PN-$PV
DESCRIPTION="Python bindings for the cairo library"
HOMEPAGE="https://www.cairographics.org/pycairo/ https://github.com/pygobject/pycairo"
SRC_URI="https://github.com/pygobject/${MY_PN}/releases/download/v${PV}/${MY_P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~mips ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""
RESTRICT="test"

RDEPEND="
	!dev-python/${MY_PN}[python_targets_python2_7]
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
	>=x11-libs/cairo-1.13.1[svg]
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_PN}-${PV}"

distutils_enable_sphinx docs \
	dev-python/sphinx_rtd_theme
distutils_enable_tests setup.py

python_install() {
	distutils-r1_python_install \
		install_pkgconfig --pkgconfigdir="${EPREFIX}/usr/$(get_libdir)/pkgconfig"
}

python_install_all() {
	distutils-r1_python_install_all
	rm -r ${D}/usr/share
	rm -r ${D}/usr/lib*/pkgconfig
	rm -r ${D}/usr/include
}
