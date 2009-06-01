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
IUSE="kde xfce"

DEPEND="=sys-apps/calculate-lib-9999
        >=dev-python/python-ldap-2.0[ssl]
        >=sys-auth/pam_ldap-180[ssl]
        >=sys-auth/nss_ldap-239
        >=sys-apps/keyexec-0.1.2
        >=sys-apps/hal-0.5.9
        sys-apps/keyutils
        sys-auth/pam_keystore
        kde? ( >=kde-misc/kgtk-0.9.5[qt4]
	       >=kde-base/kdm-4.2.0[-kdeprefix] )
	xfce? ( x11-misc/slim )"

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
