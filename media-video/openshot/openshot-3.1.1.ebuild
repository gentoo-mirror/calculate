# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 xdg

MY_PN="${PN}-qt"

DESCRIPTION="Award-winning free and open-source video editor"
HOMEPAGE="https://openshot.org/"
SRC_URI="https://github.com/OpenShot/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3+"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/httplib2[${PYTHON_SINGLE_USEDEP}]
	dev-python/PyQt5[${PYTHON_SINGLE_USEDEP},gui,svg,widgets]
	dev-python/PyQtWebEngine[${PYTHON_SINGLE_USEDEP}]
	dev-python/pyzmq[${PYTHON_SINGLE_USEDEP}]
	dev-python/requests[${PYTHON_SINGLE_USEDEP}]
	>=media-libs/libopenshot-0.3.2:0=[python,${PYTHON_SINGLE_USEDEP}]"
DEPEND=""
BDEPEND="$(python_gen_cond_dep '
		doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	')"

PATCHES=( "${FILESDIR}/${P}-fix-pybuild.patch" )

python_compile_all() {
	use doc && emake -C doc html
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/html/. )
	distutils-r1_python_install_all
}

python_test() {
	cd "${BUILD_DIR}/install$(python_get_sitedir)/${PN}_qt/" || die
	"${EPYTHON}" tests/query_tests.py -v --platform minimal  || die
}
