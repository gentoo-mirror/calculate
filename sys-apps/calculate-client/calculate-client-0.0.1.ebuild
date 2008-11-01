# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

inherit distutils subversion

ESVN_REPO_URI="http://svn.calculate.ru/calculate2/calculate-client/tags/0.0.1/"

DESCRIPTION="The program adjusts the user account"
HOMEPAGE="http://www.calculate-linux.ru/Calculate_2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=sys-apps/calculate-lib-0.0.1
        >=dev-python/python-ldap-2.0
        >=sys-auth/pam_ldap-180
        >=sys-auth/nss_ldap-239"
