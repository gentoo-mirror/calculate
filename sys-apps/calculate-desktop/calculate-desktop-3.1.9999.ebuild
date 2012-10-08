# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate-3/calculate-desktop.git"

DESCRIPTION="The program of the desktop configuration Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="kde xfce gnome"

DEPEND="~sys-apps/calculate-lib-3.1.9999
	>=dev-python/python-ldap-2.0[ssl]
	xfce? ( x11-misc/xdialog )
	gnome? ( x11-misc/xdialog )
	kde? ( kde-base/kdialog )"

RDEPEND="${DEPEND}"

pkg_postinst() {
	#${EROOT}/usr/lib/calculate-2.2/calculate-desktop/bin/install
	if use kde || use xfce || use gnome;
	then
		ewarn "Please restart xdm for refreshing configuration files."
	fi
}

pkg_prerm() {
	:
	#${EROOT}/usr/lib/calculate-2.2/calculate-desktop/bin/uninstall
}
