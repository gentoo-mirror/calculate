# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_REPO_URI="git://git.calculate.ru/calculate-client.git"

DESCRIPTION="The program of setting and storing the user account in the domain"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~x86"
IUSE="kde xfce gnome"

DEPEND="=sys-apps/calculate-desktop-2.2.9999
		>=dev-python/python-ldap-2.0[ssl]
		>=sys-auth/pam_ldap-180[ssl]
		>=sys-auth/nss_ldap-239
		>=sys-apps/keyexec-0.1.2
		>=sys-apps/hal-0.5.9
		sys-apps/keyutils
		sys-auth/pam_keystore
		dev-python/py-smbpasswd
		xfce? ( x11-misc/slim
				x11-misc/xdialog )
		gnome? ( gnome-base/gdm
				 x11-misc/xdialog )
		kde? ( kde-base/kdm
		       kde-base/kdialog )"

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
