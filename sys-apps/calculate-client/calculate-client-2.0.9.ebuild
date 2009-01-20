# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit distutils

SRC_URI="ftp://ftp.local.calculate.ru/pub/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The program adjusts the user account"
HOMEPAGE="http://www.calculate-linux.ru/Calculate_2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=sys-apps/calculate-lib-2.0.6
        >=dev-python/python-ldap-2.0[ssl]
        >=sys-auth/pam_ldap-180[ssl]
        >=sys-auth/nss_ldap-239
        >=kde-misc/kgtk-0.9.5[qt4]
        >=kde-misc/gtk-kde4-0.8.0
		>=app-admin/sudo-1.6.9[ldap,pam]
		sys-apps/keyutils
		"
