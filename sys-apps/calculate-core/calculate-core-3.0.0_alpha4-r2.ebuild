# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3/${PN}/${P}.tar.bz2"

DESCRIPTION="The WSDL core for Calculate 3"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"

DEPEND="~sys-apps/calculate-lib-3.0.0_alpha4
	>=dev-python/soaplib-1.0
	dev-python/suds
	dev-python/pyopenssl
	dev-libs/openssl
	dev-python/m2crypto
	dev-python/cherrypy"
RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo "For autoconfigure calculate-core for adminuser perform:"
	einfo "  cl-core --bootstrap <username>"
	einfo "For run calculate-core perform:"
	einfo "  /etc/init.d/calculate3 start"
	einfo "Add calcualte core to autorun:"
	einfo "  rc-update add calculate3 boot"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# remove test methods, update to alpha5
	epatch "${FILESDIR}/calculate-core-3.0.0_alpha4-r2.patch"

	# remove cl-console
	epatch "${FILESDIR}/calculate-core-3.0.0_alpha4-fixsetup.patch"
}
