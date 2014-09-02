# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3/${PN}/${P}.tar.bz2
	http://mirror.yandex.ru/calculate/calculate3/${PN}/${P}.tar.bz2"

DESCRIPTION="The program of the desktop configuration Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="~sys-apps/calculate-core-3.2.0_alpha12
	>=dev-python/python-ldap-2.0[ssl]
	media-gfx/feh
	x11-apps/xmessage
	!<sys-apps/calculate-desktop-3.1.0_alpha1
	sys-apps/keyutils
	sys-auth/pam_keystore
	sys-auth/pam_client
	dev-lang/swig"
RDEPEND="${DEPEND}"
