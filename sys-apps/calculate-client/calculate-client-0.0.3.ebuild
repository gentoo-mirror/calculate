# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

inherit distutils

SRC_URI="ftp://ftp.local.calculate.ru/pub/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The program adjusts the user account"
HOMEPAGE="http://www.calculate-linux.ru/Calculate_2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=sys-apps/calculate-lib-0.0.2
        >=dev-python/python-ldap-2.0
        >=sys-auth/pam_ldap-180
        >=sys-auth/nss_ldap-239
		>=kde-misk/kgtk-0.9.5
		>=kde-misc/gtk-kde4-0.8.0"
