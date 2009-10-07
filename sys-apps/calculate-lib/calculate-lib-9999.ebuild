# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_REPO_URI="git://git.calculate.ru/dev/calculate2/calculate-lib.git"

DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.org/Calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/python-ldap-2.0[ssl]
		>=dev-python/pyxml-0.8"
RDEPEND="${DEPEND}"
