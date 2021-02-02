# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# DO NOT ADD pypy to PYTHON_COMPAT
# pypy bundles a modified version of cffi. Use python_gen_cond_dep instead.
PYTHON_COMPAT=( python2_7 )

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2 toolchain-funcs
MY_PN=cffi
MY_P=$MY_PN-$PV

DESCRIPTION="Foreign Function Interface for Python calling C code"
HOMEPAGE="https://cffi.readthedocs.io/ https://pypi.org/project/cffi/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"
RESTRICT="test"

DEPEND="dev-libs/libffi:="
RDEPEND="${DEPEND}
	!dev-python/cffi[python_targets_python2_7]
	dev-python/pycparser-python2[${PYTHON_USEDEP}]"
BDEPEND="${RDEPEND}
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
	virtual/pkgconfig"

distutils_enable_sphinx doc/source

PATCHES=(
	"${FILESDIR}"/cffi-0.14.0-g-line.patch
)

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	tc-export PKG_CONFIG
}


python_install_all() {
	distutils2_python_install_all
	rm -r ${D}/usr/share
}
