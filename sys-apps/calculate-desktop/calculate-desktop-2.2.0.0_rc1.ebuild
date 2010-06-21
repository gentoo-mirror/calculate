# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_COMMIT="3c0c16d2b723e009f9feff6165f2cd1a34bf6730"
EGIT_REPO_URI="git://git.calculate.ru/calculate-desktop.git"

DESCRIPTION="The program of the desktop configuration Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde xfce gnome"

DEPEND="=sys-apps/calculate-lib-2.2.9999
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

pkg_postinst() {
	${EROOT}/usr/lib/calculate-2.2/calculate-desktop/bin/install
	if use kde || use xfce || use gnome;
	then
		ewarn "Please restart xdm for refreshing configuration files."
	fi
}

pkg_prerm() {
	${EROOT}/usr/lib/calculate-2.2/calculate-desktop/bin/uninstall
}
