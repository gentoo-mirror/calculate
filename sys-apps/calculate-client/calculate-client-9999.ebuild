# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Copyright 2008-2009 Calculate Pack, http://www.calculate-linux.ru

EAPI="2"

inherit distutils git

EGIT_REPO_URI="git://git.calculate.ru/dev/calculate2/calculate-client.git"

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

RDEPEND="${DEPEND}"

ISUPDATE=/tmp/${PN}.ebuild.update

# for fixing bug of ebuild calculate-client-2.0.17
OLDISUPDATEPATH="${PORTAGE_TMPDIR}/portage/${CATEGORY}/${PN}-2.0.17/temp/"
OLDISUPDATE="${OLDISUPDATEPATH}/${PN}.update"

pkg_preinst() {
	touch ${ISUPDATE}
	rm -f /etc/init.d/client

	# for fixing bug of ebuild calculate-client-2.0.17
	mkdir -p ${OLDISUPDATEPATH}
	touch ${OLDISUPDATE}
}

pkg_postinst() {
	cl-client --install
	rm ${ISUPDATE}

	# for fixing bug of ebuild calculate-client-2.0.17
	rm -rf ${PORTAGE_TMPDIR}/portage/${CATEGORY}/${PN}-2.0.17
	rmdir ${PORTAGE_TMPDIR}/portage/${CATEGORY} &>/dev/null
}

pkg_prerm() {
	# for fixing bug of ebuild calculate-client-2.0.17 (|| -e ${OLDISUPDATE} )
	if ! [[ -e ${ISUPDATE} || -e ${OLDISUPDATE} ]];
	then
		cl-client --uninstall
	fi
}
