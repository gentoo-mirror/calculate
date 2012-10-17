# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate-2.2/calculate-client.git"

DESCRIPTION="The program of setting and storing the user account in the domain"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="kde xfce gnome"

DEPEND="~sys-apps/calculate-desktop-2.2.9999
	~sys-apps/calculate-lib-2.2.9999
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
