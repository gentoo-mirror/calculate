# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3/${PN}/${P}.tar.bz2"

DESCRIPTION="Qt gui console client for WSDL Calculate 3"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"

DEPEND="~sys-apps/calculate-core-3.0.0_alpha5
	dev-python/dbus-python
	dev-python/imaging
	dev-python/pyside[script]"
RDEPEND="${DEPEND}"
