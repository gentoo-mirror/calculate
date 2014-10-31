# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3/${PN}/${P}.tar.bz2
	http://mirror.yandex.ru/calculate/calculate3/${PN}/${P}.tar.bz2"

DESCRIPTION="The program of setting and storing the user account in the domain"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS=""

DEPEND="~sys-apps/calculate-desktop-3.2.3
	!<sys-apps/calculate-client-3.1.0
	>=dev-python/python-ldap-2.0[ssl]
	>=sys-auth/pam_ldap-180[ssl]
	>=sys-auth/nss_ldap-239
	sys-apps/keyutils
	sys-auth/pam_keystore
	sys-auth/pam_client
	dev-lang/swig"

RDEPEND="${DEPEND}"

python_install() {
	distutils-r1_python_install --install-scripts=/usr/sbin
}
