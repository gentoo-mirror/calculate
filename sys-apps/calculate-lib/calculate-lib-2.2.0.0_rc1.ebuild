# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_COMMIT="6bb79dd23d0f0c2621ecf1eb331c94aff2278237"
EGIT_REPO_URI="git://git.calculate.ru/calculate-lib.git"

DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/python-ldap-2.0[ssl]
	dev-python/py-smbpasswd
	>=dev-python/pyxml-0.8"
RDEPEND="${DEPEND}"
