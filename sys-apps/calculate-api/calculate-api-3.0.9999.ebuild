# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate-3/calculate-api.git"

DESCRIPTION="The WSDL api for Calculate 3"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~sys-apps/calculate-lib-3.0.9999
	>=dev-python/soaplib-1.0
	dev-python/suds
	dev-python/pyopenssl
	dev-libs/openssl
	dev-python/m2crypto
	dev-python/cherrypy"
RDEPEND="${DEPEND}"
