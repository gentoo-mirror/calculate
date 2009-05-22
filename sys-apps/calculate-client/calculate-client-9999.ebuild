# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit distutils subversion

ESVN_REPO_URI="http://svn.calculate.ru/calculate2/calculate-client/trunk/"

DESCRIPTION="The program of setting and storing the user account in the domain"
HOMEPAGE="http://www.calculate-linux.ru/Calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=sys-apps/calculate-lib-9999
        >=dev-python/python-ldap-2.0[ssl]
        >=sys-auth/pam_ldap-180[ssl]
        >=sys-auth/nss_ldap-239
        >=sys-apps/keyexec-0.1.2
        >=sys-apps/hal-0.5.9
        sys-apps/keyutils
        sys-auth/pam_keystore"

pkg_postinst() {
	cl-client --install
}

pkg_prerm() {
	cl-client --uninstall
}
