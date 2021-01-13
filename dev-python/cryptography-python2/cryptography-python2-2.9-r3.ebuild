# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils-r1 flag-o-matic
MY_PN=cryptography
MY_P=$MY_PN-$PV

VEC_P=cryptography_vectors-${PV}
DESCRIPTION="Library providing cryptographic recipes and primitives"
HOMEPAGE="https://github.com/pyca/cryptography/ https://pypi.org/project/cryptography/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz
	test? ( mirror://pypi/c/cryptography_vectors/${VEC_P}.tar.gz )"

LICENSE="|| ( Apache-2.0 BSD )"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"
IUSE="libressl idna test"
RESTRICT="test"

# the openssl 1.0.2l-r1 needs to be updated again :(
# It'd theb be able to go into the || section again
#=dev-libs/openssl-1.0.2l-r1:0
# the following is the original section, disallowing bindist entirely
#!libressl? ( >=dev-libs/openssl-1.0.2:0=[-bindist(-)] )
RDEPEND="
	!dev-python/cryptography[python_targets_python2_7]
	!libressl? ( >=dev-libs/openssl-1.0.2o-r6:0= )
	libressl? ( >=dev-libs/libressl-2.8:0= )
	idna? ( >=dev-python/idna-2.1[${PYTHON_USEDEP}] )
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
	>=dev-python/six-python2-1.4.1[${PYTHON_USEDEP}]
	dev-python/enum34[${PYTHON_USEDEP}]
	dev-python/ipaddress[${PYTHON_USEDEP}]
	>=dev-python/cffi-python2-1.8:=[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS=( AUTHORS.rst CONTRIBUTING.rst README.rst )

python_configure_all() {
	append-cflags $(test-flags-CC -pthread)
}

python_install_all() {
	distutils-r1_python_install_all
	rm -r ${D}/usr/share
}
