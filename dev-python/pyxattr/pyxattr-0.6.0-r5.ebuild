# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2 eutils

DESCRIPTION="Python interface to xattr"
HOMEPAGE="https://pyxattr.k1024.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	https://pyxattr.k1024.org/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2.7"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 m68k ~mips ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux"
RESTRICT="test"

RDEPEND="sys-apps/attr
	!dev-python/pyxattr:0[python_targets_python2_7]"
DEPEND="${RDEPEND}
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${PN}-0.6.0-xattr_header.patch"
)

python_prepare_all() {
	sed -i -e 's:, "-Werror"::' setup.py || die
	# Bug 548486
	sed -e "s:html_theme = 'default':html_theme = 'classic':" \
		-i doc/conf.py || die

	distutils2_python_prepare_all
}

python_install_all() {
	distutils2_python_install_all
	rm -r ${D}/usr/share
}
