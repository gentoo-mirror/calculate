# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate-3/calculate-client.git"

DESCRIPTION="Utility for setting and storing the user accounts in the domain"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS=""
IUSE="kde xfce gnome"

DEPEND="~sys-apps/calculate-desktop-3.2.9999
	~sys-apps/calculate-lib-3.2.9999
	>=dev-python/python-ldap-2.0[ssl]
	>=sys-auth/pam_ldap-180[ssl]
	>=sys-auth/nss_ldap-239
	>=sys-apps/keyexec-0.1.2
	sys-apps/keyutils
	dev-lang/swig
	sys-auth/pam_keystore
	xfce? ( x11-misc/xdialog )
	gnome? ( x11-misc/xdialog )
	kde? ( kde-base/kdialog )"

RDEPEND="${DEPEND}"

python_install() {
	distutils-r1_python_install --install-scripts=/usr/sbin
}
