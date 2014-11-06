# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3/${PN}/${P}.tar.bz2
	http://mirror.yandex.ru/calculate/calculate3/${PN}/${P}.tar.bz2"

DESCRIPTION="The program of update Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="~sys-apps/calculate-core-3.2.3
	~sys-apps/calculate-install-3.2.3
	dev-python/pexpect"

RDEPEND="${DEPEND}"

pkg_preinst() {
	dosym /usr/sbin/cl-core /usr/sbin/cl-update
	dosym /usr/sbin/cl-core /usr/sbin/cl-update-profile
}

src_unpack() {
    unpack "${A}"
    cd "${S}"

    # apply revision changes
    epatch "${FILESDIR}/calculate-update-3.2.3-r2.patch"
}
