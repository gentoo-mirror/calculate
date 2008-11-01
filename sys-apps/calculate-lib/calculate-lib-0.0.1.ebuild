# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

inherit distutils subversion

ESVN_REPO_URI="http://svn.calculate.ru/calculate2/calculate-lib/tags/0.0.1/"

DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.ru/Calculate_2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=dev-python/python-ldap-2.0
        >=dev-python/pyxml-0.8"
