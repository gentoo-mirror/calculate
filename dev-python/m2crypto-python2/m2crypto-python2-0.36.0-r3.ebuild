# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2 toolchain-funcs

MY_PN="M2Crypto"
DESCRIPTION="A Python crypto and SSL toolkit"
HOMEPAGE="https://gitlab.com/m2crypto/m2crypto https://pypi.org/project/M2Crypto/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~mips ppc ppc64 ~s390 sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="libressl"
RESTRICT="test"

RDEPEND="
	!dev-python/m2crypto[python_targets_python2_7]
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	dev-python/typing-python2
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/swig-2.0.9
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_PN}-${PV}"

PATCHES=(
	"${FILESDIR}/m2crypto-libressl-0.31.0.patch"
)

swig_define() {
	local x
	for x; do
		if tc-cpp-is-true "defined(${x})"; then
			SWIG_FEATURES+=" -D${x}"
		fi
	done
}

src_prepare() {
	# TODO
	sed -e 's:test_server_simple_timeouts:_&:' \
		-i tests/test_ssl.py || die
	distutils2_src_prepare
}

python_compile() {
	# setup.py looks at platform.machine() to determine swig options.
	# For exotic ABIs, we need to give swig a hint.
	local -x SWIG_FEATURES=

	# https://bugs.gentoo.org/617946
	swig_define __ILP32__

	# https://bugs.gentoo.org/674112
	swig_define __ARM_PCS_VFP

	distutils2_python_compile --openssl="${ESYSROOT}"/usr
}

python_install_all() {
	distutils2_python_install_all
	rm -r ${D}/usr/share
}
