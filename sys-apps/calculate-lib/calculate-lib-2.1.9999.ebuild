# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 git-2

EGIT_REPO_URI="git://git.calculate-linux.org/calculate-2.1/calculate-lib.git"

DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-python/python-ldap-2.0[ssl]
		>=dev-python/pyxml-0.8"
RDEPEND="${DEPEND}"
