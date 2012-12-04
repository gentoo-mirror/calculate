# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3/${PN}/${P}.tar.bz2"

DESCRIPTION="The WSDL core for Calculate 3"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS=""
IUSE="minimal"

DEPEND="~sys-apps/calculate-lib-3.1.1_alpha2
	>=dev-python/soaplib-1.0
	!minimal? ( dev-python/sudsds
	net-libs/dslib
	dev-python/pyopenssl
	dev-libs/openssl
	dev-python/m2crypto
	dev-python/cherrypy )"
RDEPEND="${DEPEND}"

pkg_preinst() {
	dosym /usr/sbin/cl-core /usr/sbin/cl-core-setup
}

pkg_postinst() {
	einfo "For autoconfigure calculate-core for adminuser perform:"
	einfo "  cl-core --bootstrap <username>"
	einfo "For run calculate-core perform:"
	einfo "  /etc/init.d/calculate-core start"
	einfo "Add calcualte core to autorun:"
	einfo "  rc-update add calculate-core boot"
}
src_unpack() {
    unpack "${A}"
    cd "${S}"

    # apply revision changes
    epatch "${FILESDIR}/calculate-core-3.1.1_alpha2-r6.patch"
}
