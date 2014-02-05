# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3/${PN}/${P}.tar.bz2"

DESCRIPTION="The program of setting and storing the user account in the domain"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-desktop-3.1.9
	!<sys-apps/calculate-client-3.1.0
	>=dev-python/python-ldap-2.0[ssl]
	>=sys-auth/pam_ldap-180[ssl]
	>=sys-auth/nss_ldap-239
	>=sys-apps/keyexec-0.1.2
	dev-qt/qtdbus
	sys-apps/keyutils
	sys-auth/pam_keystore
	sys-auth/pam_client
	dev-lang/swig"

RDEPEND="${DEPEND}"

src_unpack() {
    unpack "${A}"
    cd "${S}"

    # apply revision changes
    epatch "${FILESDIR}/calculate-client-3.1.9-r3.patch"
}
