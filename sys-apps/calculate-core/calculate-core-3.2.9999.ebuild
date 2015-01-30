# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate-3/calculate-core.git"

DESCRIPTION="The WSDL api for Calculate 3"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS=""
IUSE=""

DEPEND="~sys-apps/calculate-lib-3.2.9999
	>=dev-python/soaplib-1.0
	dev-python/sudsds
	dev-python/pyopenssl
	dev-libs/openssl
	=dev-python/m2crypto-0.21.1-r2
	dev-python/cherrypy"
RDEPEND="${DEPEND}"

pkg_preinst() {
	distutils-r1_pkg_preinst

	dosym /usr/sbin/cl-core /usr/sbin/cl-core-setup
	dosym /usr/sbin/cl-core /usr/sbin/cl-core-patch
}
