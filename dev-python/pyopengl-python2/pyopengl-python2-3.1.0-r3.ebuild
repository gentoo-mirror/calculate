# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2

ORIG_PN=pyopengl
MY_PN="PyOpenGL"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/ https://pypi.org/project/PyOpenGL/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
#	mirror://sourceforge/pyopengl/${MY_P}.tar.gz" # broken mirror for this release
LICENSE="BSD"

SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
RESTRICT="test"
IUSE=""

RDEPEND="
	!dev-python/${ORIG_PN}[python_targets_python2_7]
	media-libs/freeglut
	virtual/opengl
	x11-libs/libXi
	x11-libs/libXmu"
DEPEND="${RDEPEND}
	dev-python/setuptools-python2[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
