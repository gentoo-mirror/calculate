# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Copyright 2008-2009 Calculate Pack, http://www.calculate-linux.ru

EAPI="2"

inherit distutils subversion

ESVN_REPO_URI="http://svn.calculate.ru/calculate2/calculate-lib/trunk/"

DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.ru/Calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/python-ldap-2.0[ssl]
		>=dev-python/pyxml-0.8"
RDEPEND="${DEPEND}"
